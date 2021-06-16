class BadsController < ApplicationController

 def create
    @bad = Bad.new(user_id: current_user.id, movie_id: params[:movie_id])

    if @good = Good.find_by(user_id: current_user.id, movie_id: params[:movie_id])
      @good.destroy
    end
    @bad.save
    redirect_to movie_path(params[:movie_id])
 end

 def destroy
    @bad = Bad.find_by(user_id: current_user.id, movie_id: params[:movie_id])
    @bad.destroy
    redirect_to movie_path(params[:movie_id])
 end

end
