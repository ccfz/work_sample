Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'movies/index'
      get 'movies/filter'
    end
  end
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
