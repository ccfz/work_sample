class AddCountRatingsToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :count, :integer
    add_index :movies, :count
    add_column :movies, :rating, :decimal
    add_index :movies, :rating
  end
end
