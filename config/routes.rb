Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # /api/v1/authentications
  namespace :api, defaults: {format: :hash} do
    get 'public', to: 'public#establish_connection'

    post '/auth/login', to: 'authentication#login'

    get '/categories', to: 'categories#index'
    get '/categories/:name', to: 'categories#show'
    post '/categories', to: 'categories#create'

    post '/articles', to: 'articles#create'
    get '/articles/:slug', to: 'articles#show'
  end
end
