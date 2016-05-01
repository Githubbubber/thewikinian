require 'bcrypt'
require 'faker'
require 'pry'
require 'pg'

# thewikinian
#   articles    (id, title, author, original_body)
#   categories  (id, a_id, tag)
#   colleagues  (id, username, password, email, profile_pic)
#   edits       (id, a_id, c_id, latest_body)
#   timestamps  (id, a_id, orig_post_ts, latest_post_ts)

module TheWikinian
  class Server < Sinatra::Base

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
      @articles = conn.exec "SELECT * FROM articles LIMIT 3"
      erb :index
    end

    get "/abouttw" do
      business_stuff
      @desc = Faker::Hipster.paragraphs(3)
      @desc2 = Faker::Hipster.paragraphs(3)
      erb :abouttw
    end

    get "/articles" do
      @articles = conn.exec "SELECT * FROM articles"
      # binding.pry
      erb :articles
    end

    get "/articles/:id" do
      @article_id = params[:id].to_i
      @article = conn.exec "SELECT * FROM articles WHERE id=#{@article_id}"
      # binding.pry
      erb :articles
    end

    post "/articles" do
      @title = params[:title]
      @author = current_user["username"]
      @body = params[:body]
      conn.exec_params("INSERT INTO articles (title, author, original_body) VALUES ($1, $2, $3)", [@title, @author, @body])
      # binding.pry
      redirect "/articles"
    end

    put "/articles/:id" do
      @article_id = params[:id].to_i
      @title = params[:title]
      @latest_body = params[:body]
      conn.exec_params("UPDATE articles SET title = $1 WHERE id = #{@article_id}", [@title])
      # binding.pry
      redirect "/articles"
    end

    get "/colleagues" do
      @colleagues = conn.exec "SELECT * FROM colleagues"
      # binding.pry
      erb :colleagues
    end

    get "/colleagues/:id" do
      @colleague_id = params[:id].to_i
      @colleague = conn.exec "SELECT * FROM colleagues WHERE id=#{@colleague_id}"
      # binding.pry
      erb :colleagues
    end

    get "/signup" do
        erb :signup
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
          @colleague = conn.exec_params(
            "INSERT INTO colleagues (username, password, email, profile_pic) VALUES ($1, $2, $3, $4)",
            [@username, @password, @email, @profile_pic]
          )
          session[:user_id] = @colleague["id"]
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
          "SELECT * FROM colleagues WHERE username=$1 LIMIT 1",
          [@username]
        ).first
        # binding.pry
        if @colleague["username"] == @username && BCrypt::Password::new(@colleague["password"]) == @password
          session[:user_id] = @colleague["id"]
          redirect "/"
        end
      end
    end

    private

  end
end
