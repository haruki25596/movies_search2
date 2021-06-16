class RemoveReviewIdFromBads < ActiveRecord::Migration[5.2]
  def change
    remove_column :bads, :review_id, :integer
  end
end
