class Movie < ApplicationRecord
  has_many :ratings

  scope :with_rating, lambda {
    select('CASE WHEN count(ratings) > 100
              THEN ROUND(count(ratings), -2)
              ELSE count(ratings) END as count')
      .select('movies.id AS id')
      .select('ROUND(AVG(ratings.rating)::numeric,2) AS rating')
      .select('movies.title AS title')
      .joins(:ratings)
      .having('count(ratings) > 19')
      .group(:'movies.id')
  }
  scope :with_ratings_by_age, -> (age) {
    user_ids = User.joins(:age).where('ages.title': age).select(:id)
    with_rating.where('ratings.user_id': user_ids)
  }
end
