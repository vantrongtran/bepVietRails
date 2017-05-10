Rails.application.routes.draw do
  post "/rate" => "rater#create", :as => "rate"
  devise_for :users, class_name: User.name, :controllers => { omniauth_callbacks: "omniauth_callbacks", sessions: "sessions", registrations: "registrations"}
  mount Ckeditor::Engine => "/ckeditor"
  namespace :admin do
    root "dashboard#index"
    resources :foods
    resources :food_target_conditions, only: [:new, :create]
    resources :categories
    resources :category_trees, only: :index
    resources :food_trees, only: :index
    resources :ingredients
    resources :posts
  end
  resources :foods
  resources :hashtags
  resources :relationships
  resources :comments
  resources :posts do
    resources :comments
  end
  resources :users, only: :show do
    resources :following, only: :index
    resources :followers, only: :index
  end
  resources :users
  resources :condition_details
  resources :user_conditions, only: :create
  resources :likes, only: [:create, :destroy]
  root "static_pages#index"
end
