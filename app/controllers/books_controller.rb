class BooksController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  
  private
  
  def book_params
    params.require(:book).premit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(oarams[:id])
    @user = @book.user
    redirect_to book_path unless @user == current_user
  end
end
