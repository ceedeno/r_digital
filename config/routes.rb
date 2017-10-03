Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: 'registration' }
  resources :users
end
