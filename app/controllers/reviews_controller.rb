class ReviewsController < ApplicationController
  def index
  end


  def show
    @reviews = Review.where(movie_id: @review.movie_id)
    @current_user_reviews_movie_id = current_user.reviews.find_by(movie_id: @review.movie_id)
  end
  
  def review_params
    params.require(:review).permit(:movie_id, :title, :user_id, :body)
  end
end
