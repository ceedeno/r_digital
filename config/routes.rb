Rails.application.routes.draw do
  resources :journals do
    patch 'combine_pdfs'
  end
  resources :articles do
    patch 'update_users_article'
  end
  root to: 'visitors#index'
  
  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :users
  resources :visitors, only: [:index]

  get 'iframe', to: 'visitors#iframe'
end
