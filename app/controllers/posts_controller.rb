require 'faker'
class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    #select one post by its id and display it
    @post = Post.find(params[:id])
  end

  # def create
  #   # create a new post here using params passed from a form
  #   # send the user to show so they can see their new post
  #   if params[:title] != nil && params[:author] != nil  && params[:content] != nil
  #     id = Post.create(title: params[:title],
  #                       author: params[:author],
  #                       content: params[:content])
  #   end
  #   byebug
  #   redirect_to id
  # end

  def create
    # byebug
    if params[:commit] == "Hipster"
      # Title field
      fhs   = Faker::Hipster.sentence.gsub(/[.]/, "").titleize
      # Author field
      fnfn  = Faker::Name.first_name.capitalize + ", hipster clone"
      # Content field
      fhp   = "\"" + Faker::Hipster.paragraphs.join(" ") + "\""
      # Add post to db
      id = Post.create(title: fhs, author: fnfn, content: fhp)
    elsif params[:commit] == "Hacker"
      # Title field
      fha   = Faker::Hacker.adjective.gsub(/[.]/, "").split.map(&:capitalize)*' '
      # Author field
      fnfn2 = Faker::Name.first_name.capitalize + ", hacker whiz"
      # Content field
      fhsss = "\"" + Faker::Hacker.say_something_smart.capitalize + "\""
      # Add post to db
      id = Post.create(title: fha, author: fnfn2, content: fhsss)
     elsif params[:commit] == "Star Wars"
      # Title field
      swq   = "A Star Wars Quote"
      # Author field
      fswc  = Faker::StarWars.character
      # Content field
      fswq  = "\"" + Faker::StarWars.quote.capitalize + "\""
      # Add post to db
      id = Post.create(title: swq, author: fswc, content: fswq)
    end
    redirect_to id
  end

  # def hipster
  #   # Title field
  #   fhs   = Faker::Hipster.sentence.gsub(/[.]/, "").titleize
  #   # Author field
  #   fnfn  = Faker::Name.first_name.capitalize + ", hipster clone"
  #   # Content field
  #   fhp   = Faker::Hipster.paragraphs.join(" ")
  #   # Add post to db
  #   id = Post.create(title: fhs, author: fnfn, content: fhp)
  #   redirect_to id
  # end

  # def hacker
  #   # Title field
  #   fha   = Faker::Hacker.adjective.gsub(/[.]/, "").split.map(&:capitalize)*' '
  #   # Author field
  #   fnfn2 = Faker::Name.first_name.capitalize + ", hacker whiz"
  #   # Content field
  #   fhsss = "\"" + Faker::Hacker.say_something_smart.capitalize + "\""
  #   # Add post to db
  #   id = Post.create(title: fha, author: fnfn2, content: fhsss)
  #   redirect_to id
  # end

  # def starwars
  #   # Title field
  #   swq   = "A Star Wars Quote"
  #   # Author field
  #   fswc  = Faker::StarWars.character
  #   # Content field
  #   fswq  = Faker::StarWars.quote.capitalize
  #   # Add post to db
  #   id = Post.create(title: swq, author: fswc, content: fswq)
  #   redirect_to id
  # end

  # private
  #   def post_params
  #     # allow params to be entered and used from post form

  #     # # Only [a-zA-Z\d_] allowed in the table data
  #     # fhs = (/[\W^ ]/.match(fhs) === nil) ? fhs : "Dud"
  #     # fha = (/[\W ]/.match(fha) === nil) ? fha : "Dud"
  #     params.require(:post).permit(:title, :author, :content)
  #   end
end
