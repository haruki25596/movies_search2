class MoviesController < ApplicationController

  before_action :set_q, only: [:index, :search]

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
    @interests = Interest.find_by(user_id: current_user.id, movie_id: params[:id])# current_userが該当のmovieをお気に入り登録済みか確認するための検索
    @interest_users = Interest.where(movie_id: params[:id]).count # 該当のmovieをお気に入りしているuserの数を調べる
    @reviews = Review.where(movie_id: params[:id])
    @good_id = Good.where(user_id: current_user.id)
    @bad_id = Bad.where(user_id: current_user.id)
  end

  def movie_params
      params.require(:movie).permit(:title, :body, :user_id)
  end

end
