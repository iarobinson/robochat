Robochat::Engine.routes.draw do
  resources :messages, only: [:index, :create]
  root 'messages#index'
  
  # Optional provider-specific routes
  get '/claude', to: 'messages#claude' if Robochat.configuration.providers.include?(:claude)
  get '/openai', to: 'messages#openai' if Robochat.configuration.providers.include?(:openai)
end