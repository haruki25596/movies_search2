class GoodsController < ApplicationController
  
  def create
    Good.create(user_id: current_user.id,movie_id: params[:movie_id])
    redirect_to root_path
  end
  
  def destroy
  end
end
