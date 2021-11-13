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
      create_list(:movie, 150)
      get "/api/v1/movies/index"

      parsed_body = JSON.parse(response.body)
      expect(parsed_body.length).to eq(100)
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
        "title" => "Harry Potter",
        "rating" => "3.45",
        "count" => "2.0"
      })
    end

    context "ratings count" do
      it "should be rounded to the nearest hundred" do
        movie = create(:movie, title: 'Harry Potter')
        ratings = create_list(:rating, 1505, movie: movie)

        get "/api/v1/movies/index"


        parsed_body = JSON.parse(response.body)
        first_movie = parsed_body.first
        expect(first_movie).to include({
          "count"=>"1500.0"
        })
      end
    end

    context "order" do
      it "should order movies by their rating and count" do
        lotr_movie = create(:movie, title: 'Lord of the Rings')
        m_movie = create(:movie, title: 'Matrix')
        hr_movie = create(:movie, title: 'Harry Potter')

        create(:rating, movie: hr_movie, rating: 4)
        create(:rating, movie: lotr_movie, rating: 3)
        create(:rating, movie: m_movie, rating: 3)
        create(:rating, movie: m_movie, rating: 3)
        get "/api/v1/movies/index"

        parsed_body = JSON.parse(response.body)

        pp parsed_body

        expect(parsed_body[0]["title"]).to eq('Harry Potter')
        expect(parsed_body[1]["title"]).to eq('Matrix')
        expect(parsed_body[2]["title"]).to eq('Lord of the Rings')
      end
    end
  end
end
