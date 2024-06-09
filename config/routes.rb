Rails.application.routes.draw do
  resources :participants
  resources :chats do
    resources :messages
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "chats#index"
end
