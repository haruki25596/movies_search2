class AddDetailsToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :user_id, :integer
    add_column :movies, :review_id, :integer
    add_column :movies, :title, :string
    add_column :movies, :body, :text
  end
end
