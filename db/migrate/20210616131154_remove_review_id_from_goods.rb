class RemoveReviewIdFromGoods < ActiveRecord::Migration[5.2]
  def change
    remove_column :goods, :review_id, :integer
  end
end
