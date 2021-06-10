class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id]) 
    @reviews = @user.reviews.page(params[:page]).reverse_order
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :image, :email, :introduction)
  end
  
end
