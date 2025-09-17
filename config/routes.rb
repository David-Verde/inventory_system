Rails.application.routes.draw do
  resources :marcas
  resources :modelos

  resources :articulos do
    resources :transferencias, only: [:new, :create]
  end
  resources :personas
  
  root "articulos#index"
end