require 'bcrypt'
require 'faker'
require 'pry'
require 'pg'

# thewikinian
#   articles    (id, title, c_id, original_body)
#   categories  (id, a_id, tag)
#   colleagues  (id, username, password, email, profile_pic)
#   edits       (id, a_id, c_id, latest_body)
#   timestamps  (id, a_id, orig_post_ts, latest_post_ts)

module TheWikinian
  class Server < Sinatra::Base

    set :method_override, true

    enable :sessions

    def business_stuff
      @catch_phrase = Faker::Company.catch_phrase
    end

    def conn
      PG.connect(dbname: "thewikinian")
    end

    def current_user
      @current_user = (session[:user_id])? conn.exec("SELECT * FROM colleagues WHERE id=#{session[:user_id]}").first : nil
    end

    def logged_in?
      current_user
    end

    get "/" do
      @articles = conn.exec "SELECT * FROM articles, colleagues WHERE articles.c_id = colleagues.id LIMIT 3"
      erb :index
    end

    get "/abouttw" do
      business_stuff
      @desc = Faker::Hipster.paragraphs(3)
      @desc2 = Faker::Hipster.paragraphs(3)
      erb :abouttw
    end

    get "/articles" do
      logged_in?
      @articles = conn.exec "SELECT * FROM articles"
      # binding.pry
      erb :articles
    end

    get "/articles/:id" do
      current_user
      @article_id = params[:id].to_i
      @article = conn.exec "SELECT a.*, c.a_id, c.tag, coll.id, coll.username, edits.latest_body, ts.latest_post_ts FROM articles AS a LEFT JOIN categories AS c ON (c.a_id = a.id) LEFT JOIN edits ON (edits.c_id = a.c_id) LEFT JOIN colleagues AS coll ON (coll.id = a.c_id) LEFT JOIN timestamps AS ts ON (ts.a_id = a.id) WHERE a.id = #{@article_id}"
      # binding.pry
      erb :articles
    end

    post "/articles" do
      if logged_in?
        @title = params[:title_new]
        @id = params[:article_id_new].to_i
        @body = params[:body_new]
        @cat = params[:cat]
        # binding.pry
        conn.exec_params("INSERT INTO articles (title, c_id, original_body) VALUES ($1, $2, $3)", [@title, @id, @body])
        conn.exec_params("UPDATE edits SET a_id = $1,latest_body = $2 WHERE c_id = #{@coll_id}", [@article_id, @latest_body])
        conn.exec_params("UPDATE categories SET tag = $1 WHERE a_id = #{@article_id}", [@cat])
        redirect "/articles"
      else
        redirect "/"
      end
    end

    put "/articles" do
        @article_id = params[:article_id].to_i
        @coll_id = params[:coll_id].to_i
        @title = params[:title]
        @latest_body = params[:body]
        @cat = params[:cat]
        # binding.pry
        conn.exec_params("UPDATE articles SET title = $1, c_id = $2 WHERE id = #{@article_id}", [@title, @coll_id])
        conn.exec_params("UPDATE edits SET a_id = $1,latest_body = $2 WHERE c_id = #{@coll_id}", [@article_id, @latest_body])
        conn.exec_params("UPDATE categories SET tag = $1 WHERE a_id = #{@article_id}", [@cat])

        @article = conn.exec "SELECT a.*, c.a_id, c.tag, coll.id, coll.username, edits.latest_body, ts.latest_post_ts FROM articles AS a LEFT JOIN categories AS c ON (c.a_id = a.id) LEFT JOIN edits ON (edits.c_id = a.c_id) LEFT JOIN colleagues AS coll ON (coll.id = a.c_id) LEFT JOIN timestamps AS ts ON (ts.a_id = a.id) WHERE a.id = #{@article_id}"
        erb :articles
    end

    get "/colleagues" do
      logged_in?
      @colleagues = conn.exec "SELECT * FROM colleagues"
      # binding.pry
      erb :colleagues
    end

    delete "/colleagues" do
      @id_to_delete = params[:id].to_i
      conn.exec "DELETE * FROM colleagues WHERE id = #{@id_to_delete}"
      # binding.pry
      redirect "/"
    end

    get "/colleagues/:id" do
      logged_in?
      @colleague_id = params[:id].to_i
      @colleague = conn.exec "SELECT * FROM colleagues WHERE id=#{@colleague_id}"
      # binding.pry
      erb :colleagues
    end

    get "/signup" do
      if logged_in?
        erb :index
      else
        erb :signup
      end
    end

    post "/signup" do
      if params.has_value?("") || params[:pass_first] != params[:pass_confirm]
        @submitted = true
        erb :signup
      elsif params[:pass_first] == params[:pass_confirm]
          @username = params[:username]
          @password = BCrypt::Password::create(params[:pass_confirm])
          @email = params[:email]
          @profile_pic = params[:profile_pic]

          conn.exec_params(
            "INSERT INTO colleagues (username, password, email, profile_pic) VALUES ($1, $2, $3, $4)",
            [@username, @password, @email, @profile_pic]
          )
          @colleague = conn.exec("SELECT id FROM colleagues WHERE username = '#{@username}'")
          # binding.pry
# SIGN UP
          session[:user_id] = @colleague[0]["id"].to_i
# SESSION[:USER_ID]
          redirect "/"
      end
    end

    get "/login" do
      if logged_in?
        erb :index
      else
        erb :login
      end
    end

    post "/login" do
      if params.has_value?("")
        @submitted = true
        erb :login
      else
        @username = params[:username]
        @password = params[:password]
        @colleague = conn.exec_params(
          "SELECT * FROM colleagues WHERE username=$1",
          [@username]
        ).first
        # binding.pry
        if @colleague && BCrypt::Password::new(@colleague["password"]) == @password
# LOG IN
          session[:user_id] = @colleague["id"].to_i
# SESSION[:USER_ID]
          redirect "/"
        else
          erb :login
        end
      end
    end

    private

  end
end
