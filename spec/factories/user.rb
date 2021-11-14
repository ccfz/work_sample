FactoryBot.define do
  factory :user do
    gender { "F" }
    age { create(:age) }
    occupation { create(:occupation) }
    zipcode { "S2342"}
  end
end
