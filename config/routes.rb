Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users
  resources :visitors, only: [:index]

  get 'iframe', to: 'visitors#iframe'
end
