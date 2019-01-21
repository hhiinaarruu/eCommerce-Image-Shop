Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :charges, only: [:new, :create, :index]
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
