Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "sessions"}
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    root "dashboard#index"
    resources :foods
    resources :categories
    resources :ingredients
  end
  resources :hashtags
  root "static_pages#index"
end
