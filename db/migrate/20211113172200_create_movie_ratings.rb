class CreateMovieRatings < ActiveRecord::Migration[6.0]
  def change
    create_view :movie_ratings, materialized: true
    add_index :movie_ratings, :id, unique: true
  end
end
