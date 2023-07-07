Rails.application.routes.draw do
    
  resources :users
  post '/users/login', to: 'users#login'  

  resources :restaurants, only: [:index]
  get '/restaurants', to: 'restaurants#index'
  get '/restaurant/:name', to: 'restaurants#show'
  post '/restaurants/create', to: 'restaurants#create'

  post 'dish/create', to: 'dishes#create'
  get '/dish/:name', to: 'dishes#show'


  get '/category', to: 'categories#index'
  get '/category/:name', to: 'categories#show'

  get 'dish', to: 'dishes#index'
  
  get '/user/dish', to: 'users#search_dishes'
end
