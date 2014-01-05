Pdvaf::Application.routes.draw do
  resources :condicionesdepagos

  resources :configuraciones

  resources :conceptos

  resources :monedas

  resources :productos

  resources :unidades

  resources :clientes

  resources :metodosdepagos

  resources :formasdepagos

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end