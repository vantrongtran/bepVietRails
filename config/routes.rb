Rails.application.routes.draw do
  devise_for :users, :controllers => {sessions: 'sessions'}
  namespace :admin do
    root "dashboard#index", path: "/"
  end
  root "static_pages#index"
end
