Pdvaf::Application.routes.draw do
  
  get '/empresas/newuser', to: 'empresas#newuser'
  post '/empresas/createuser', to: 'empresas#createuser'
  
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