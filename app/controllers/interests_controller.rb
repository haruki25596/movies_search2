class InterestsController < ApplicationController

  def index
    @interests = current_user.interests
  end

  def create
    @interest = current_user.interests.build(movie_id: params[:movie_id], title: params[:title], poster_path: params[:poster_path])
    movie = Tmdb::Movie.detail(params[:movie_id])
    @interest.title = movie.title
    @interest.poster_path = movie.poster_path
    @interest.save
    redirect_to request.referer, notice: "気になるリストに追加しました"
  end

  def destroy
    @interest = current_user.interests.find_by(movie_id: params[:movie_id])
    @interest.destroy
    redirect_to request.referer, alert: "気になるリストから削除しました"
  end

end
