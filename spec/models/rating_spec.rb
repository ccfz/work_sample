require "rails_helper"

RSpec.describe Rating, type: :model do
    it "has a valid factory" do
      rating = build(:rating);

      expect(rating).to be_valid
    end
end