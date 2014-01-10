Pdvaf::Application.routes.draw do
  resources :empresas

  resources :sucursales

  resources :conceptos

  resources :remisiones

  resources :condicionesdepagos

  resources :configuraciones

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