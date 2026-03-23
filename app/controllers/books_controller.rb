class BooksController < ApplicationController
  def index
    if params[:search].present?
      @books = Book.joins(:author, :genre)
                   .where("books.title LIKE ? OR authors.name LIKE ?",
                          "%#{params[:search]}%",
                          "%#{params[:search]}%")
                   .includes(:author, :genre)
                   .page(params[:page]).per(12)
    else
      @books = Book.all.includes(:author, :genre).page(params[:page]).per(12)
    end
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end
end
