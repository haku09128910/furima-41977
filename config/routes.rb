Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: [:new, :create, :index, ]
get 'categories/:id', to: 'categories#show', as: 'category'
end