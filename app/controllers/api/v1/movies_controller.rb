class Api::V1::MoviesController < ApplicationController
  def index
    movies = Movie
              .select(:id, :title, :count, :rating)
              .where("count > 19")
              .order(rating: :desc, count: :desc)
              .limit(100)
    render json: movies
  end
end
