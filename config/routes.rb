
Rails.application.routes.draw do
  get 'sugget_food/index'

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
    resources :tips, controller: 'tips', type: 'tip'
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
  resources :search
  resources :users
  resources :condition_details
  resources :user_conditions, only: :create
  resources :likes, only: [:create, :destroy]
  resources :suggest_foods, only: :index
  root "static_pages#index"
end
