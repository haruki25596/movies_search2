class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    # ここから
    @user.create_notification_follow!(current_user)
    # ここまで
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def follow
    current_user.follow(params[:id])
    User.find(params[:id]).create_notification_follow!(current_user)
    redirect_to users_path
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to users_path
  end

  # フォローしている人一覧
  def follower
    user = User.find(params[:id])
    @users = user.follower_user
  end

  # フォローされている人一覧
  def followed
    user = User.find(params[:id])
    @users = user.following_user
  end

end
