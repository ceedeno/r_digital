Rails.application.routes.draw do
  resources :journals do
    patch 'combine_pdfs'
  end
  resources :articles do
    patch 'update_users_article'
    patch 'update_correction_note'
  end
  root to: 'visitors#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users
  resources :visitors, only: [:index]

  get 'iframe', to: 'visitors#iframe'
  get 'statistics', to: 'visitors#statistics'

end
