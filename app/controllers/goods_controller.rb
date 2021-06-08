class GoodsController < ApplicationController
  
  def create
    @review = Review.find(params[:review_id])
    Good.create(user_id: current_user.id,review_id: params[:review_id])
    redirect_to root_path
  end
  
  def destroy
  end
end
