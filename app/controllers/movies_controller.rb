class MoviesController < ApplicationController
  before_action :redirect_root, except: [:index, :show, :search]

  require 'themoviedb-api'
  Tmdb::Api.key("6ce86077881a441d243745e068c0f6dc")
  Tmdb::Api.language("ja") # 映画情報の表示の際の言語設定を日本語にできる



  def index
    @movies = Movie.all
    if params[:keyword].present?
      @tmdbs= JSON.parse(Tmdb::Search.movie(params[:keyword]).to_json)
    else
      @tmdbs = JSON.parse(Tmdb::Movie.upcoming.to_json)
    end
  end

  def search
    @movies = Movie.all
    if params[:keyword].present?
      @tmdbs= JSON.parse(Tmdb::Search.movie(params[:keyword]).to_json)
    else
      @tmdbs = JSON.parse(Tmdb::Movie.upcoming.to_json)
    end
  end

  def set_q
    @q = Movie.ransack(params[:q])
  end

  def show
    @movie = Tmdb::Movie.detail(params[:id])
    @reviews = Review.where(movie_id: params[:id])
    if user_signed_in?
      @good = Good.find_by(user_id: current_user.id, movie_id: params[:id])
      @bad = Bad.find_by(user_id: current_user.id, movie_id: params[:id])
      @user_goods = Good.where(movie_id: params[:id])
      @user_bads = Bad.where(movie_id: params[:id])
      if Good.exists?(user_id: current_user.id, movie_id: @movie.id)
        @good = Good.find_by(user_id: current_user.id, movie_id: @movie.id)
      end
      if Bad.exists?(user_id: current_user.id, movie_id: @movie.id)
        @bad = Bad.find_by(user_id: current_user.id, movie_id: @movie.id)
      end
    end
  end

  def movie_params
      params.require(:movie).permit(:title, :body, :user_id)
  end

  private

  def redirect_root
    redirect_to new_user_session_path unless user_signed_in?
  end

end
