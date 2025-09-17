Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :marcas
  resources :modelos

  resources :articulos do
    resources :transferencias, only: [:new, :create]
  end
  resources :personas
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  root "articulos#index"
end