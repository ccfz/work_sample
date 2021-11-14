class Api::V1::MoviesController < ApplicationController
  def index
    movies = MovieRating
              .limit(100)
              .order(rating: :desc, count: :desc)
    render json: movies
  end
end
