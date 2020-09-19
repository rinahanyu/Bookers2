class BooksController < ApplicationController
  before_action :ensure_correct_user, {only:[:edit]}
  
  def index
    @books = Book.all
    @book = Book.new
  end
  
  def show
    @book = Book.new
    @book1 = Book.find(params[:id])
  end
  
  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      render("books/index")
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render("books/edit")
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    if current_user.id != @user.id
      redirect_to books_path 
    end
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
