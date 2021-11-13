class Api::V1::MoviesController < ApplicationController
  def index
    movies = MovieRating.limit(50)

    render json: movies
  end
end
