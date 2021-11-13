require 'rails_helper'

RSpec.describe "Api::V1::Movies", type: :request do

  before(:all) do
    create_list(:movie, 100)
  end

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/movies/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns the first 50 movies" do
      get "/api/v1/movies/index"

      parsed_body = JSON.parse(response.body)
      expect(parsed_body.length).to eq(50)
    end
  end

end
