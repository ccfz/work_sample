class MovieRating < ApplicationRecord
  belongs_to :movie
  self.primary_key= :id

end
