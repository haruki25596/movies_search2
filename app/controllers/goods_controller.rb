class GoodsController < ApplicationController

  def create
    @good = Good.new(user_id: current_user.id, movie_id: params[:movie_id])
    @movie_id = @good.movie_id

    if bad = Bad.find_by(user_id: current_user.id, movie_id: params[:movie_id])
      bad.destroy
    end
    @good.save
    @goods_count = Good.where(movie_id: params[:movie_id]).count
    @bads_count = Bad.where(movie_id: params[:movie_id]).count
  end

  def destroy
    good = Good.find_by(user_id: current_user.id, movie_id: params[:movie_id])
    @movie_id = good.movie_id
    good.destroy
    @goods_count = Good.where(movie_id: params[:movie_id]).count
    @bads_count = Bad.where(movie_id: params[:movie_id]).count
  end
end
