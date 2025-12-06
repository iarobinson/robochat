Robochat::Engine.routes.draw do
  root to: "chats#index"
  post "/ask", to: "chats#ask"
end
