class MoviesController < ApplicationController

  require 'themoviedb-api'
  Tmdb::Api.key("6ce86077881a441d243745e068c0f6dc")
  Tmdb::Api.language("ja") # 映画情報の表示の際の言語設定を日本語にできる


  def search
    @tmdbs = Tmdb::Search.movie(params[:q])
  end

  def show
  end
end
