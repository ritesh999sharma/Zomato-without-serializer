Rails.application.routes.draw do
    
  resources :users
  post 'login', to: 'users#login' 
  get '/user/dish', to: 'users#search_dishes'
  get '/user/:user_type', to: 'users#show'
  delete '/user/:name', to: 'users#destroy'

  resources :restaurants, only: [:index]
  get '/restaurant', to: 'restaurants#index'
  # get '/restaurant/:name', to: 'restaurants#show'
  post '/restaurant/create', to: 'restaurants#create'
  get 'restaurant/:name', to: 'restaurants#check_dishes'  
  delete 'restaurant/:name', to: 'restaurants#destroy'
  patch 'restaurant/:id', to: 'restaurants#update'

  post 'dish/create', to: 'dishes#create'
  get '/dish/:name', to: 'dishes#show'
  get 'dish', to: 'dishes#index'
  delete '/dish/:name', to: 'dishes#destroy'
  patch '/dishes/:id', to: 'dishes#update'


  get '/category', to: 'categories#index'
  get '/category/:name', to: 'categories#show'

  post 'create-cart', to: 'cart#create_cart'
  post 'add-to-cart', to: 'cart#add_to_cart'
  post 'dishes-buy', to: 'cart#dishes_buy'
 
end
