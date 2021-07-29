class ReviewCommentController < ApplicationController
  def new
    @review_comment = ReviewComment.new
    @review_comments = ReviewComment.where(review_id: params[:review_id]).page(params[:page]).per(8)
    @review = Review.find(params[:review_id])
  end
  
  def create
    review = Review.find(params[:review_id])
    comment = current_user.review_comments.new(review_comment_params)
    comment.review_id = review.id
    @review = comment.review
    comment.save
    @review.create_notification_review_comment!(current_user, review.user_id, review.id)
    redirect_to new_review_review_comment_path(review)
  end
end
