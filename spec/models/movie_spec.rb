require "rails_helper"

RSpec.describe Movie, type: :model do
    it "has a valid factory" do
      movie = build(:movie);

      expect(movie).to be_valid
    end
end