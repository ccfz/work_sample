# Getting started
1. `bundle install`
2. `yarn install` 
3. Run the migrations: `rails db:migrate`
4. Add the database dump
5. Run the rake task: `rails movies:rating`

# Tests

* For the  backend run `rspec`
* For the frontend run `yarn test`

# Filter by age

Simply pick  the age group and click calculate. To go back to the full list just choose "All ages" and press calculate.


# The task:

## Task 1: Top 100

Build a movie app (website) with a charts page that displays the top 100 movies from the database. The chart view is the only page to implement and it should include:

* `#` - position
* `Title` - movie title
* `Rating` - average rating (2 digits after decimal point)
* `Count` - amount of ratings (rounded by hundrets)

To avoid the usual problems with too few data points, the movie chart considers only movies that have more than 20 ratings. The position depends on the average rating of the movie. If two movies have the same average, then the one with more ratings has the higher position.

The charts page will have the highest load in the app and must be displayed in under 50 ms on commodity hardware.

The app assumes that at some point later in the development cycle users will be able to insert new ratings. Changes in the ratings table should have immediate impact (< 10s) on the charts.

The user should also be able to filter the charts by age. This means she will be shown the top 100 movies rated only by users within the selected age range. As this feature is used less often, the rendering time can be up to 1 second.
