Rails.application.routes.draw do
  get 'movies/search'
  get 'movies/show'
  get 'users/show'
  devise_for :users
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
