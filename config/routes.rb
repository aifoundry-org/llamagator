Rails.application.routes.draw do
  resources :chats
  resources :messages

  get "up" => "rails/health#show", as: :rails_health_check

  root "messages#index"
end
