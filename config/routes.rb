Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :megaliths, only: [:index, :show, :new, :create, :update] do
    resources :trips, only: [:new, :create]
    resources :favourites, only: :create
    resources :comments, only: :create
    resources :visiteds, only: :create
    resources :megalith_photos, only: :create
  end
  get "users/search", to: "users#search", as: :users_search
  resources :users, only: [:index, :show, :edit, :update]
  resources :trips, only: [:edit, :update, :show, :destroy]
  resources :trip_users, only: [:create, :destroy]
  get "trips/:id/finalise_trip", to: "trips#finalise_trip_edit", as: :finalise_trip_edit
end
