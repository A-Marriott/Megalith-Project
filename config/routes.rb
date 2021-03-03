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
  resources :users, only: [:show, :edit, :update] do
    resources :trips, only: [:edit, :update]
  end
  resources :trips, only: [:destroy]
end
