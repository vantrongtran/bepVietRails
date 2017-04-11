Rails.application.routes.draw do
  devise_for :users, :controllers => {sessions: 'sessions'}
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    root "dashboard#index", path: "/"
    resources :foods
    resources :categories
  end
  root "static_pages#index"
end
