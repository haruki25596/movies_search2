class ReviewsController < ApplicationController
  def index
    @q = Review.ransack(params[:q])
    @reviews = @q.result(distinct: true).page(params[:page]).reverse_order
    # @genres = GENRES
    gon.movie_id = Review.all.pluck(:movie_id)
    gon.review_id = Review.all.pluck(:id)
  end


  def show
    @q = Review.ransack(params[:q])
    @review = Review.find(params[:id])

    gon.movie_id = Review.find(params[:id]).movie_id
    @current_user_interests_movie_id = current_user.interests.pluck(:movie_id)

    @reviews = Review.where(movie_id: @review.movie_id)
    @interests = Interest.all.where(movie_id: @review.movie_id)
    @current_user_reviews_movie_id = current_user.reviews.find_by(movie_id: @review.movie_id)
  end
  
  def review_params
    params.require(:review).permit(:movie_id, :title, :user_id, :body)
  end
end
