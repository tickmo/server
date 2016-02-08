Rails.application.routes.draw do
  root 'static_pages#home'

  resources :users
  match '/signup',  to: 'users#new', via: 'get'

  resources :sessions, only: [:new, :destroy, :create]
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end
