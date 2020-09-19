class UsersController < ApplicationController
  before_action :ensure_correct_user, {only:[:edit]}
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render("users/edit")
    end
  end
  
  def index
   @book = Book.new
   @users = User.all
  end
  
  def ensure_correct_user
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user) 
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
