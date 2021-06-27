class BadsController < ApplicationController

 def create
    @bad = Bad.new(user_id: current_user.id, movie_id: params[:movie_id])
    @movie_id = @bad.movie_id

    if good = Good.find_by(user_id: current_user.id, movie_id: params[:movie_id])
      good.destroy
    end
    @bad.save
    @bads_count = Bad.where(movie_id: params[:movie_id]).count
    @goods_count = Good.where(movie_id: params[:movie_id]).count
 end

 def destroy
    bad = Bad.find_by(user_id: current_user.id, movie_id: params[:movie_id])
    @movie_id = bad.movie_id
    bad.destroy
    @bads_count = Bad.where(movie_id: params[:movie_id]).count
    @goods_count = Good.where(movie_id: params[:movie_id]).count
 end

end
