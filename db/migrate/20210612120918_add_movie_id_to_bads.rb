class AddMovieIdToBads < ActiveRecord::Migration[5.2]
  def change
    add_column :bads, :movie_id, :integer
  end
end
