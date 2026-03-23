class AuthorsController < ApplicationController
  def index
    @authors = Author.all.includes(:books)
  end

  def show
    @author = Author.find(params[:id])
    @books = @author.books.includes(:genre)
  end
end
