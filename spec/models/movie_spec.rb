require 'rails_helper'

RSpec.describe Movie, type: :model do
  it 'has a valid factory' do
    movie = build(:movie)

    expect(movie).to be_valid
  end

  describe '.filter_by_age' do
    it 'includes ratings by users in the received age' do
      lotr_movie = create(:movie, title: 'Lord of the Rings')
      allowed_age = create(:age, id: 1, title: '35-44')
      create_list(:user_with_rating, 20, movie: lotr_movie, age: allowed_age)
      create(:rating, movie: lotr_movie)

      expect(Movie.with_ratings_by_age('35-44')[0].count).to eq(20.0)
    end
  end
end
