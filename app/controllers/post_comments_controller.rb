class PostCommentsController < ApplicationController
  
  def create
    @review = Review.find(params[:review_id])
    @comment = current_user.comments.new(post_comment_params)
    @comment.review_id = review.id
    @comment.save
    redirect_to review_post_comments_path
    
  end

  def destroy
    @PostComment.find_by(id: params[:id], review_id: params[:review_id]).destroy
    redirect_to review_post_comments_path(params[:review_id])
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment, :user_id, :review_id)
  end
  
end
