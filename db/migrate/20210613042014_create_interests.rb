class CreateInterests < ActiveRecord::Migration[5.2]
  def change
    create_table :interests do |t|
      t.integer :user_id
      t.integer :movie_id
      t.string :title
      t.string :poster_path

      t.timestamps
    end
  end
end
