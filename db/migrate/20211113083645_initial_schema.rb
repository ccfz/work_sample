class InitialSchema < ActiveRecord::Migration[6.0]
  def change
    create_table 'ages', id: :integer, force: :cascade do |t|
      t.string 'title', limit: 16
    end

    create_table 'movies', id: :integer, force: :cascade do |t|
      t.string 'title', limit: 128
      t.string 'genres', limit: 256
    end

    create_table 'occupations', id: :integer, force: :cascade do |t|
      t.string 'title', limit: 32
    end

    create_table 'ratings', id: :integer, force: :cascade do |t|
      t.integer 'user_id'
      t.integer 'movie_id'
      t.decimal 'rating', precision: 11, scale: 2
      t.datetime 'created_at'
      t.index %w[movie_id user_id], name: 'movie_id_user_id', unique: true
    end

    create_table 'users', id: :integer, force: :cascade do |t|
      t.string 'gender', limit: 1
      t.integer 'age_id', limit: 2
      t.integer 'occupation_id', limit: 2
      t.string 'zipcode', limit: 16
    end
  end
end
