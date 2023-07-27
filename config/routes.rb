# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profiles/edit'
  root to: 'products#index'
  # config/routes.rb
  resource :profile, only: %i[edit update]

  devise_for :users, controllers: { registrations: 'users/registrations' }
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

  resources :discounts

  resources :carts do
    post 'apply_discount', on: :member
  end
  

end
