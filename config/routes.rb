Rails.application.routes.draw do
  resources :games, only: %i[index show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "games#index"
end
