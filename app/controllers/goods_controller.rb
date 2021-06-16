class GoodsController < ApplicationController

  def create
    @good = Good.new(user_id: current_user.id, movie_id: params[:movie_id])

    if @bad = Bad.find_by(user_id: current_user.id, movie_id: params[:movie_id])
      @bad.destroy
    end
    @good.save
    redirect_to movie_path(params[:movie_id])
  end

  def destroy
    @good = Good.find_by(user_id: current_user.id, movie_id: params[:movie_id])
    @good.destroy
    redirect_to movie_path(params[:movie_id])
  end
end
