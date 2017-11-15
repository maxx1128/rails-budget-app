Rails.application.routes.draw do

  root 'static_pages#home'

  get '/login', to: "static_pages#login"
  post '/login', to: "static_pages#login_post"

  get '/all-months', to: 'categories#index'

  get '/categories/edit', to: 'categories#edit'
  get '/categories/:year/:month', to: 'categories#month'
  get '/categories/:year/:month/:id', to: 'categories#show'

  get '/categories/:year/:month/:id/new_expense', to: 'expenses#new_in_category'

  resources :categories
  resources :expenses
end
