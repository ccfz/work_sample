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

  test('renders the movies position, title, rating and count', () => {
    useMovies.mockReturnValue([
      {id: '2342', title: "Toy Story (1995)", rating: "4.50", count: '232' },
      {id: '2343', title: "Jumanji (1995)", rating: "3", count: '232' }
    ])
    render(<Movie />);

    expect(screen.getByText('1')).toBeTruthy();
    expect(screen.getByText('Toy Story (1995)')).toBeTruthy();
    expect(screen.getByText("4.50")).toBeTruthy();

    expect(screen.getByText('2')).toBeTruthy();
    expect(screen.getByText('Jumanji (1995)')).toBeTruthy();
    expect(screen.getByText("3")).toBeTruthy();
  })
});
