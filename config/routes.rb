Robochat::Engine.routes.draw do
  resources :messages, only: [:index, :create]
  root 'messages#index'
end
