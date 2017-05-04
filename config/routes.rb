Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, controllers: {sessions: "sessions", registrations: "registrations"}
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    root "dashboard#index"
    resources :foods
    resources :categories
    resources :ingredients
  end
  resources :foods
  resources :hashtags
  resources :foods
  resources :users
  resources :posts
  resources :condition_details
  resources :relationships
  root "static_pages#index"
end
