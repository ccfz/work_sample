FactoryBot.define do
  factory :user do
    gender { 'F' }
    age { create(:age) }
    occupation { create(:occupation) }
    zipcode { 'S2342' }
  end

  factory :user_with_rating, parent: :user do
    transient do
      movie { create(:movie) }
      user_age { create(:age) }
    end

    gender { 'F' }
    age { user_age }
    occupation { create(:occupation) }
    zipcode { 'S2342' }

    after(:create) do |user, options|
      create(:rating, movie: options.movie, user: user)
    end
  end
end
