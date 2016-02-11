Rails.application.routes.draw do
  root 'static_pages#home'

  resources :users
  match '/signup',  to: 'users#new', via: 'get'

  resources :sessions, only: [:create, :destroy]
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  # API resources.
  namespace :api do
    namespace :v1 do
      resources :users,    only: [:index, :create, :show, :update, :destroy]
      resources :sessions, only: [:create]
    end
  end
end
