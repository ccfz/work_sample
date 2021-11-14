import { useState, useEffect } from 'react';

const useMovies = () => {
  const [movies, setMovies] = useState([]);

  const url = "/api/v1/movies/index";

  function newQuery(age) {
    const url = `/api/v1/movies/filter?age=${age}`;

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
  }

  function ageFilter(age) {
    if (age == 0) {
      const url = `${baseUrl}/index`;
      movieRequest(url)
    } else {
      const url = `${baseUrl}filter?age=${age}`;
      movieRequest(url)
    }

  }

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

  return [movies, newQuery]
}

export default useMovies;
