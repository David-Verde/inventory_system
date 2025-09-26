Rails.application.routes.draw do
  get "image_imports/create"
  resource :session
  resources :passwords, param: :token
  resources :marcas
  resources :modelos

  resources :articulos do
    resources :transferencias, only: [ :new, :create ]
  end
  resources :personas
  
  post "image_imports", to: "image_imports#create"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  root "articulos#index"
end