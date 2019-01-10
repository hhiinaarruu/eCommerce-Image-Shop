Rails.application.routes.draw do

  resources :charges, only: [:new, :create]
  resources :line_items
  resources :carts
  resources :pictures do
    collection do
      get :search
    end
  end

  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  root 'pictures#index'
end
