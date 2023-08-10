# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profiles/edit'
  root to: 'products#index'
  get 'logout', to: 'sessions#logout', as: :logout
  # config/routes.rb
  resource :profile, only: %i[edit update]
  post '/sessions/user', to: 'sessions#create'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  # devise_for :users, skip: [:sessions]
  devise_scope :user do
    get '/users/users_list', to: 'users/registrations#users_list', as: :users_list
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products do
    resources :reviews
  end
  resources :products do
    collection do
      get :search
    end
  end
  get 'search', to: 'products#search'

  resources :products do
    resources :cart_items, only: %i[create update destroy]
  end

  resource :cart, only: :show do
    post 'pay_bill', on: :member
    get 'invoice', on: :member
  end

  get 'cart/invoice', to: 'carts#invoice', as: :invoice

  resource :cart, only: :show
  resources :carts do
    post 'apply_discount', on: :member
  end

  resources :discounts

  # resources :sessions, only: [:new, :create, :destroy]

  get 'download', to: 'carts#download_pdf'
end
