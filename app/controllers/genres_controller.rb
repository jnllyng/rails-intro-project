class GenresController < ApplicationController
  def index
    @genres = Genre.all.includes(:books)
  end

  def show
    @genre = Genre.find(params[:id])
    @books = @genre.books.includes(:author)
  end
end
