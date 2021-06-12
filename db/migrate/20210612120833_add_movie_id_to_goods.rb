class AddMovieIdToGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :goods, :movie_id, :integer
  end
end
