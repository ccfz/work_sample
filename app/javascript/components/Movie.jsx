import React, { useState } from 'react';
import useMovies from '../hooks/useMovies';


const Movie = () => {
  const [selectedAge, setSelectedAge] = useState(0);
  const [movies, fetchWithFilter] = useMovies();
  const styles = {
    container: {
      flexDirection: 'column'
    }
  }

  function handleChange (e){
    setSelectedAge(e.target.value);
  }

  function applyFilter() {
    fetchWithFilter(selectedAge)
  }

  const columnNames = ['#', 'Title', 'Rating', 'Count'];
  const columnKeys = ['title', 'rating', 'count']
  return (
    <div style={styles.container}>
      <h1>Top 100</h1>

      <div>
        <select
          value={selectedAge}
          onChange={handleChange}
        >
          <option value={0}>All ages</option>
          <option value="Under 18">Under 18</option>
          <option value="18-24">18-24</option>
          <option value="25-34">25-34</option>
          <option value="35-44">35-44</option>
          <option value="45-49">45-49</option>
          <option value="50-55">50-55</option>
          <option value="56+">56+</option>
        </select>

        <button onClick={applyFilter}>Calculate</button>
      </div>
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
            )
          })}
        </tbody>
      </table>
    </div>

  );
}

export default Movie;