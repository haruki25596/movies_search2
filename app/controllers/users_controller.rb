class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    @user_goods = @user.goods
    @user_reviews = @user.reviews

    #　Goodの合計を計算する
    @goods_count = 0
    @user_reviews.each do |review|
      @goods_count += review.goods.count
    end
    #　Badの合計を計算する
    @bads_count = 0
    @user_reviews.each do |review|
      @bads_count += review.bads.count
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id),notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :image, :email, :introduction)
  end

end
