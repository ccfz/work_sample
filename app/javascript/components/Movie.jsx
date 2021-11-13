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

  const columnNames = ['#', 'Title', 'Rating', 'Count'];
  const columnKeys = ['title', 'rating', 'count']
  return (
    <div style={styles.container}>
      <h1>Top 100</h1>
      <button>Calculate</button>
      <table>
        <thead>
          <tr>
            {columnNames.map((name, index) => (
            <td key={index}>{name}</td>
            ))}
          </tr>
        </thead>
        <tbody>
          {movies.map((movie, index) => {

            return (
              <tr key={movie.id}>
                <td>{index + 1}</td>
                {columnKeys.map((key) => (
                  <td key={`${movie.id}:${key}`} >{movie[key]}</td>
                ))}
              </tr>
          )})}
        </tbody>
      </table>
    </div>

  );
}

export default Movie;