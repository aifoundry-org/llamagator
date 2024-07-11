Rails.application.routes.draw do
  resources :prompts do
    resources :test_runs, only: [:new, :create]
  end

  resources :test_results, only: :update

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
