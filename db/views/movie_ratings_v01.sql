SELECT
  movies.id AS id,
  movies.title AS title,
  COUNT(ratings) AS count,
  ROUND(AVG(ratings.rating)::numeric,2) AS rating
FROM movies
LEFT JOIN ratings ON ratings.movie_id = movies.id
GROUP BY movies.id