require 'rails_helper'

RSpec.describe Age, type: :model do
  it 'has a valid factory' do
    age = build(:age)

    expect(age).to be_valid
  end
end
