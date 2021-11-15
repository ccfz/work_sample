require 'rails_helper'

RSpec.describe 'Api::V1::Movies', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/movies/index'

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /index' do
    it 'returns the first 100 movies' do
      create_list(:movie, 110, count: 100)

      get '/api/v1/movies/index'

      parsed_body = JSON.parse(response.body)
      expect(parsed_body.length).to eq(100)
    end

    it 'includes the ratings and count' do
      movie = create(:movie,
                     title: 'Harry Potter',
                     count: 20,
                     rating: '3.45')

      get '/api/v1/movies/index'

      parsed_body = JSON.parse(response.body)
      first_movie = parsed_body.first
      expect(first_movie).to eq({
                                  'id' => movie.id,
                                  'title' => 'Harry Potter',
                                  'rating' => '3.45',
                                  'count' => 20
                                })
    end

    context 'ranking' do
      it 'ranks the movies by their rating and count' do
        create(:movie, title: 'Lord of the Rings',
                       rating: 3, count: 20)
        create(:movie, title: 'Matrix', rating: 3, count: 21)
        create(:movie, title: 'Harry Potter', rating: 4, count: 21)

        get '/api/v1/movies/index'

        parsed_body = JSON.parse(response.body)
        expect(parsed_body[0]['title']).to eq('Harry Potter')
        expect(parsed_body[1]['title']).to eq('Matrix')
        expect(parsed_body[2]['title']).to eq('Lord of the Rings')
      end
    end
  end

  describe 'GET /filter' do
    it 'returns movie ratings made by users of the selected age' do
      lotr_movie = create(:movie, title: 'Lord of the Rings')
      age = create(:age, id: 1, title: 'Under 18')
      create_list(:user_with_rating, 20, movie: lotr_movie, age: age)
      create(:rating, movie: lotr_movie)

      get '/api/v1/movies/filter', params: { 'age': 'Under 18' }

      parsed_body = JSON.parse(response.body)
      first_movie = parsed_body.first
      expect(first_movie).to eq({
                                  'id' => lotr_movie.id,
                                  'title' => 'Lord of the Rings',
                                  'rating' => '4.0',
                                  'count' => 20
                                })
    end
  end
end
