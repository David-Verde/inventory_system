Rails.application.routes.draw do
  resources :articulos do
    resources :transferencias, only: [:new, :create]
  end
  resources :personas
  
  root "articulos#index"
end