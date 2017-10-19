Rails.application.routes.draw do

  root 'static_pages#home'

  get '/categories/edit', to: 'categories#edit'

  resources :categories
end
