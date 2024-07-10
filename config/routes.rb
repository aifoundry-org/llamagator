Rails.application.routes.draw do
  resources :models do
    resources :model_versions
  end
  devise_for :users
  resources :participants
  resources :chats do
    resources :messages
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "dashboard#index"
end
