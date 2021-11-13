FactoryBot.define do
  factory :movie do
    title { "Lord of the Rings" }
    genres { "Fantasy" }

    trait :with_ratings do
      after(:create) do |movie|
        create_list(:rating, 20, movie: movie)
      end
    end
  end
end
