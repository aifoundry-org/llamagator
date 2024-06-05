# frozen_string_literal: true

Rails.application.routes.draw do
  resources :prompts, except: %i[edit update] do
    resources :test_runs, only: %i[new create]
  end

  resources :compare, only: [:index]

  resources :test_results, only: %i[index update show]

  resources :models do
    resources :model_versions
  end
  devise_for :users

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'dashboard#index'
end
