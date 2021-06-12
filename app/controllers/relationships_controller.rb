class RelationshipsController < ApplicationController

  def follow
    current_user.follow(params[:id])
    redirect_to user_path
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to user_path
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
