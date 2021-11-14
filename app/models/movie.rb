class Movie < ApplicationRecord
  has_many :ratings


  def self.filter_by_age(age)
    user_ids = User.joins(:age).where("ages.title": age).select(:id)
    Movie
      .select("CASE WHEN count(ratings) > 100
      THEN ROUND(count(ratings), -2)
      ELSE count(ratings) END as count")
      .select("movies.id AS id")
      .select("ROUND(AVG(ratings.rating)::numeric,2) AS rating")
      .select("movies.title AS title")
      .joins(:ratings)
      .where("ratings.user_id": user_ids)
      .having("count(ratings) > 19")
      .group(:"movies.id")
  end
end
