import { useState, useEffect } from 'react';

const useMovies = () => {
  const [movies, setMovies] = useState([]);
  const baseUrl = '/api/v1/movies/'
  function movieRequest(url) {
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
    if (age === "0") {
      const url = `${baseUrl}/index`;
      movieRequest(url)
    } else {
      const url = `${baseUrl}filter?age=${age}`;
      movieRequest(url)
    }

  }

  useEffect(() => {
    const url = `${baseUrl}/index`;
    movieRequest(url)
  }, [])

  return [movies, ageFilter]
}

export default useMovies;
