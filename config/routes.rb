Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :stories
  resources :users, only: :show

  namespace :api do
    resources :users, only: :show
    resources :stories, only: [:create, :update, :destroy]
  end

  root 'stories#index'
end
