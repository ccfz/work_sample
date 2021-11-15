require 'rails_helper'
require 'rake'

Rake.application.rake_require 'tasks/movies'
Rake::Task.define_task(:environment)

RSpec.describe 'movies.rake', type: task do
  after do
    Rake::Task['movies:ratings'].reenable
  end

  describe ':ratings' do
    it 'aggregates movie ratings and ads them to movie table' do
      movie = create(:movie, title: 'Harry Potter')
      create_list(:rating, 10, movie: movie, rating: 3.6)
      create_list(:rating, 10, movie: movie, rating: 3.3)

      Rake::Task['movies:ratings'].invoke

      first_movie = Movie.first
      expect(first_movie).to have_attributes({
                                               'id' => movie.id,
                                               'title' => 'Harry Potter',
                                               'rating' => 3.45,
                                               'count' => 20.0,
                                               'genres' => 'Fantasy'
                                             })
    end

    it 'aggregates movie ratings and ads them to movie table' do
      movie = create(:movie, title: 'Harry Potter')
      create_list(:rating, 101, movie: movie)

      Rake::Task['movies:ratings'].invoke

      first_movie = Movie.first
      expect(first_movie).to have_attributes(count: 100.0)
    end
  end
end
