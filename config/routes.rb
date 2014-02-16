Pdvaf::Application.routes.draw do
  
  get '/empresas/newuser', to: 'empresas#newuser'
  post '/empresas/createuser', to: 'empresas#createuser'
  post '/remisiones/:id/facturar', to: 'remisiones#facturar', :as => 'facturar_remision'
  get '/remisiones/:id/series', to: 'remisiones#series'
  
  resources :empresas

  resources :sucursales

  resources :conceptos
  
  resources :remisiones do
    member { get :copiar }
  end

  resources :condicionesdepagos

  resources :configuraciones

  resources :monedas

  resources :productos do
    collection { post :import }
  end

  resources :unidades

  resources :clientes do
    collection { post :import }
  end

  resources :metodosdepagos

  resources :formasdepagos

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  
end