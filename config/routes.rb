Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, controllers: {sessions: "sessions"}
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    root "dashboard#index"
    resources :foods
    resources :categories
    resources :ingredients
  end
  resources :hashtags
  resources :foods
  resources :posts
  root "static_pages#index"
end
