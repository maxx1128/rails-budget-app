Rails.application.routes.draw do

  root 'static_pages#home'

  get '/all-months', to: 'categories#index'

  get '/categories/edit', to: 'categories#edit'
  get '/categories/:year/:month', to: 'categories#month'
  get '/categories/:year/:month/:id', to: 'categories#show'

  resources :categories
  resources :expenses
end
