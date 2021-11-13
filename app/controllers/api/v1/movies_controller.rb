class Api::V1::MoviesController < ApplicationController
  def index
    movies = MovieRating.limit(100)

    render json: movies
  end
end
