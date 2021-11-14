SELECT
  movies.id AS id,
  movies.title AS title,
  CASE WHEN count(ratings) > 100
            THEN ROUND(count(ratings), -2)
            ELSE count(ratings) END as count,
  ROUND(AVG(ratings.rating)::numeric,2) AS rating
FROM movies
LEFT JOIN ratings ON ratings.movie_id = movies.id
GROUP BY movies.id
HAVING count(ratings) > 19