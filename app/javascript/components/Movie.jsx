import React from 'react';
import useMovies from '../hooks/useMovies';


const Movie = () => {
  const movies = useMovies();
  const styles = {
    container: {
      flexDirection: 'column'
    }
  }
  if (movies.length == 0) { return null; }

  return (
    <div style={styles.container}>
      <h1>Top 100</h1>
      <button>Calculate</button>
      <table>
        <thead>
          <tr>
            <td>#</td>
            <td>Title</td>
            <td>Rating</td>
            <td>Count</td>
          </tr>
        </thead>
        <tbody>
          {movies.map((movie) => (
            <tr key={movie.id}>
              {Object.entries(movie).map(([key, value]) => (
                <td key={`${movie.id}:${key}`} >{value}</td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>

  );
}

export default Movie;