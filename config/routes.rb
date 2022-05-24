# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  
  get '/users/:id/movies', to: 'user_movies#index'
  get '/users/:user_id/movies/:movie_id', to: 'user_movies#show'
  get '/users/:user_id/movies/:movie_id/party/new', to: 'user_movie_parties#new'
  post '/users/:user_id/movies/:movie_id/party/new', to: 'user_movie_parties#create'
  get '/users/:id/discover', to: 'users#discover'
  get '/dashboard', to: 'users#show'
  get '/login', to: 'users#login'
  post '/login', to: 'sessions#create'
  
  resources :users, only: [:new, :create]
end
