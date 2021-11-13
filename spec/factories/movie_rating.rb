FactoryBot.define do
  factory :movie_rating do
    transient do
      for_movie { create(:movie) }
    end
    movie { for_movie }
    movie_id { for_movie.id }
    title { for_movie.title }
    count { 20 }
    rating { 3 }
  end
end
