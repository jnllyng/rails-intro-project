class BooksController < ApplicationController
  def index
  @genres = Genre.all
  if params[:search].present?
    @books = Book.joins(:author, :genre)
                 .where("books.title LIKE ? OR authors.name LIKE ?",
                        "%#{params[:search]}%",
                        "%#{params[:search]}%")
                 .includes(:author, :genre)
    @books = @books.where(genre_id: params[:genre_id]) if params[:genre_id].present?
    @books = @books.page(params[:page]).per(12)
  else
    @books = Book.all.includes(:author, :genre).page(params[:page]).per(12)
  end
end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end
end
