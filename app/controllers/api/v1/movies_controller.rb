class Api::V1::MoviesController < ApplicationController
  def index
    movies = Movie
             .select(:id, :title, :count, :rating)
             .where('count > 19')
             .order(rating: :desc, count: :desc)
             .limit(100)
    render json: movies
  end

  def filter
    age = filtering_params(params)
    movies = Movie
             .with_ratings_by_age(age)
             .order(rating: :desc, count: :desc)
             .limit(100)
    render json: movies
  end

  def filtering_params(params)
    params[:age]
  end
end
