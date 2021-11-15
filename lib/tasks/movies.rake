namespace :movies do
  desc 'Add aggregated ratings to movie'
    task ratings: :environment do
      Movie.in_batches.each_record do |movie|
      response = movie.ratings.select("CASE WHEN count(ratings) > 100
            THEN ROUND(count(ratings), -2)
            ELSE count(ratings) END as count")
        .select("round(avg(rating), 2) AS rating")

      movie.update(count: response[0].count, rating: response[0].rating)
    end
  end
end
