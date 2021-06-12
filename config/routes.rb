Rails.application.routes.draw do

  devise_for :users
  root 'movies#index'

  resources :movies, only: [:index, :show] do
    collection do
      get :search
    end
  end

  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  get 'users/:id/follower'=> 'relationships#follower', as: 'follower_user'
  get 'users/:id/followed'=> 'relationships#followed', as: 'followed_user'

  resources :users, only: [:index, :show, :edit, :update]

  resources :reviews, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :destroy]
  end

  post 'reviews/goods' => 'goods#create'
  post 'reviews/bads' => 'bads#create'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
