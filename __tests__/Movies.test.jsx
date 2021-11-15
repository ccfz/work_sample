import React from 'react';
import { render, screen, within, fireEvent } from '@testing-library/react';
import userEvent from "@testing-library/user-event";


import Movie from '../app/javascript/components/Movie';
import useMovies from '../app/javascript/hooks/useMovies';

jest.mock('../app/javascript/hooks/useMovies');
useMovies.mockReturnValue([
  [{id: 1, title: "Toy Story (1995)", genres: "Animation|Children's|Comedy"}],
  jest.fn()
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
    const movies = [
      {id: '2342', title: "Toy Story (1995)", rating: "4.50", count: '232' },
      {id: '2343', title: "Jumanji (1995)", rating: "3", count: '232' }
    ]
    useMovies.mockReturnValue([ movies, jest.fn()])
    render(<Movie />);

    expect(screen.getByText('1')).toBeTruthy();
    expect(screen.getByText('Toy Story (1995)')).toBeTruthy();
    expect(screen.getByText("4.50")).toBeTruthy();

    expect(screen.getByText('2')).toBeTruthy();
    expect(screen.getByText('Jumanji (1995)')).toBeTruthy();
    expect(screen.getByText("3")).toBeTruthy();
  })

  it("renders the age options", () => {
    render(<Movie />)
    expect(screen.getByRole('option', { name: 'All ages' })).toBeTruthy()
    expect(screen.getByRole('option', { name: 'Under 18' })).toBeTruthy()
    expect(screen.getByRole('option', { name: '18-24' })).toBeTruthy()
    expect(screen.getByRole('option', { name: '25-34' })).toBeTruthy()
    expect(screen.getByRole('option', { name: '35-44' })).toBeTruthy()
    expect(screen.getByRole('option', { name: '45-49' })).toBeTruthy()
    expect(screen.getByRole('option', { name: '50-55' })).toBeTruthy()
    expect(screen.getByRole('option', { name: '56+' })).toBeTruthy()
  });

  test("displays default selected age", () => {
    render(<Movie />)
    expect(screen.getByRole('option', { name: 'All ages' }).selected).toBe(true)
  })

  describe("when an age was selected", () => {
    test("displays default selected age", () => {
      render(<Movie />)
      expect(screen.getByRole('option', { name: 'All ages' }).selected).toBe(true)
    })

    describe("when the calculate button was pressed", () => {
      test('fetches movies for the age filter', async () => {
        const fetchSpy = jest.fn();
        useMovies.mockReturnValue([
          [{id: '2342', title: "Toy Story (1995)", rating: "4.50", count: '232' }],
          fetchSpy
        ])

        render(<Movie />);

        userEvent.selectOptions(
          screen.getByRole('combobox'),
          screen.getByRole('option', { name: '50-55' })
        )
        await fireEvent.click(screen.getByRole('button'));

        expect(fetchSpy).toHaveBeenCalledWith('50-55');
      });
    })
  })
});
