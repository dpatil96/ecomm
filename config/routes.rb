Rails.application.routes.draw do
  get 'profiles/edit'
  root to: 'products#index'
  # config/routes.rb
  resource :profile, only: [:edit, :update]


  devise_for :users, controllers: {registrations: 'users/registrations'}
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
    resources :cart_items, only: :create
  end
  
  resource :cart, only: :show
end
