class ReviewCommentController < ApplicationController
  def new
    @review_comment = ReviewComment.new
    @review_comments = ReviewComment.where(review_id: params[:review_id]).page(params[:page]).per(8)
    @review = Review.find(params[:review_id])
  end
end
