import React from 'react';
import { render, screen, within } from '@testing-library/react';

import Movie from '../app/javascript/components/Movie';
import useMovies from '../app/javascript/hooks/useMovies';

jest.mock('../app/javascript/hooks/useMovies');
useMovies.mockReturnValue([
  {id: 1, title: "Toy Story (1995)", genres: "Animation|Children's|Comedy"}
])

describe('Movie', () => {
  test('renders the title', () => {
      render(<Movie />);

      expect(screen.getByText('Top 100')).toBeTruthy();
  });

  test('renders the column titles', () => {
      render(<Movie />);

      expect(screen.getByText('#')).toBeTruthy();
      expect(screen.getByText('Title')).toBeTruthy();
      expect(screen.getByText('Rating')).toBeTruthy();
      expect(screen.getByText('Count')).toBeTruthy();
  });

  test('renders a calculate button', () => {
    render(<Movie />);

    const button = screen.getByRole('button');
    expect(within(button).getByText('Calculate')).toBeTruthy();
  });

  test('renders the movies', () => {
    useMovies.mockReturnValue([
      {id: 1, title: "Toy Story (1995)", genres: "Animation|Children's|Comedy"},
      {id: 2, title: "Jumanji (1995)", genres: "Animation|Children's|Fantasy"}
    ])
    render(<Movie />);

    expect(screen.getByText('Toy Story (1995)')).toBeTruthy();
    expect(screen.getByText("Animation|Children's|Comedy")).toBeTruthy();

    expect(screen.getByText('Jumanji (1995)')).toBeTruthy();
    expect(screen.getByText("Animation|Children's|Fantasy")).toBeTruthy();
  })
});
