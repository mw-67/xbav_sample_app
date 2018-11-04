Rails.application.routes.draw do
  resources :clients
  resources :contractors
  resources :partner_companies
  resources :employees
  resources :companies

  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout

  root 'companies#index'
end
