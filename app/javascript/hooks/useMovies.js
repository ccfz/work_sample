import { useState, useEffect } from 'react';

const useMovies = () => {
  const [movies, setMovies] = useState([]);

  const url = "/api/v1/movies/index";

  useEffect(() => {
    fetch(url)
      .then(response => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then(response => {
        setMovies(response)
      })
  }, [])

  return movies
}

export default useMovies;
