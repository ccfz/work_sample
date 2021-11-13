require 'rails_helper'

RSpec.describe "Api::V1::Movies", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/movies/index"

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns the first 100 movies" do
      create_list(:movie, 110, :with_ratings)
      MovieRating.refresh

      get "/api/v1/movies/index"

      parsed_body = JSON.parse(response.body)
      expect(parsed_body.length).to eq(100)
    end

    it "includes the ratings and count" do
      movie = create(:movie, title: 'Harry Potter')
      rating = create_list(:rating, 10, movie: movie, rating: 3.6)
      rating = create_list(:rating, 10, movie: movie, rating: 3.3)
      MovieRating.refresh

      get "/api/v1/movies/index"

      parsed_body = JSON.parse(response.body)
      first_movie = parsed_body.first
      expect(first_movie).to eq({
        "id" => movie.id,
        "title" => "Harry Potter",
        "rating" => "3.45",
        "count" => "20.0"
      })
    end

    context "ratings count" do
      it "should be rounded to the nearest hundred" do
        movie = create(:movie, title: 'Harry Potter')
        ratings = create_list(:rating, 101, movie: movie)
        MovieRating.refresh

        get "/api/v1/movies/index"

        parsed_body = JSON.parse(response.body)
        first_movie = parsed_body.first
        expect(first_movie).to include({
          "count"=>"100.0"
        })
      end
    end

    context "ranking" do
      it "ranks the movies by their rating and count" do
        lotr_movie = create(:movie, title: 'Lord of the Rings')
        m_movie = create(:movie, title: 'Matrix')
        hr_movie = create(:movie, title: 'Harry Potter')
        create_list(:rating, 20, movie: hr_movie, rating: 4)
        create_list(:rating, 20, movie: lotr_movie, rating: 3)
        create_list(:rating, 20, movie: m_movie, rating: 3)
        create_list(:rating, 1, movie: m_movie, rating: 3)
        MovieRating.refresh

        get "/api/v1/movies/index"

        parsed_body = JSON.parse(response.body)
        expect(parsed_body[0]["title"]).to eq('Harry Potter')
        expect(parsed_body[1]["title"]).to eq('Matrix')
        expect(parsed_body[2]["title"]).to eq('Lord of the Rings')
      end
    end
  end
end
