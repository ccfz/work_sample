class CreateMovieRatings < ActiveRecord::Migration[6.0]
  def change
    create_view :movie_ratings, materialized: true
  end
end
