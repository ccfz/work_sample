FactoryBot.define do
  factory :rating do
    user { create(:user) }
    movie { create(:movie) }
    rating { 4 }
  end
end
