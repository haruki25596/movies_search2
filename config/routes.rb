Rails.application.routes.draw do
  root 'movies#index'
  get 'reviews/index'
  get 'reviews/show'
  get 'movies/search'
  get 'movies/show'
  get 'users/show'
  devise_for :users
  get '/movies', to: "movies#index", as: :post_keyward
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  end

  resources :reviews, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :destroy]
  end

  resources :reviews do
    resource :good, only: [:create, :destroy]
    resource :bad, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
