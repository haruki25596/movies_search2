class BadsController < ApplicationController
  
  def create
    @review = Review.find(params[:review_id])
    Bad.create(user_id: current_user.id,review_id: params[:review_id])
    redirect_to root_path
  end
  
  def destroy
  end
  
end
