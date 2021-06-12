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
    #@movie = Movie.find(params[:id])
    @movie = Tmdb::Movie.detail(params[:id])
    #@tmdb = JSON.parse(Tmdb::Movie.movie(params[:id]).to_json)
  end

  def movie_params
      params.require(:movie).permit(:title, :body, :user_id)
  end

end
