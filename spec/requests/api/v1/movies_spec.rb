require 'rails_helper'

RSpec.describe "Api::V1::Movies", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/movies/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns the first 50 movies" do
      create_list(:movie, 50)
      get "/api/v1/movies/index"

      parsed_body = JSON.parse(response.body)
      expect(parsed_body.length).to eq(50)
    end

    it "includes the ratings and count" do
      movie = create(:movie, title: 'Harry Potter')
      rating = create(:rating, movie: movie, rating: 3.6)
      rating = create(:rating, movie: movie, rating: 3.3)

      get "/api/v1/movies/index"

      parsed_body = JSON.parse(response.body)
      first_movie = parsed_body.first
      expect(first_movie).to eq({
        "id" => movie.id,
        "title" => 'Harry Potter',
        "rating" => '3.45',
        "count" => 2
      })
    end
  end
end
