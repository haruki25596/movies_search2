class BadsController < ApplicationController

 def create
    @bad = Bad.new(user_id: current_user.id, movie_id: params[:movie_id])
    @movie_id = @bad.movie_id
    @user_bads = Bad.where(movie_id: params[:movie_id])
    @user_goods = Good.where(movie_id: params[:movie_id])

    if good = Good.find_by(user_id: current_user.id, movie_id: params[:movie_id])
      good.destroy
    end
    @bad.save
 end

 def destroy
    bad = Bad.find_by(user_id: current_user.id, movie_id: params[:movie_id])
    @user_bads = Bad.where(movie_id: params[:movie_id])
    @user_goods = Good.where(movie_id: params[:movie_id])
    @movie_id = bad.movie_id
    bad.destroy
 end

end
