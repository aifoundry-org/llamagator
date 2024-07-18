# frozen_string_literal: true

Rails.application.routes.draw do
  resources :test_runs
  resources :prompts, except: %i[edit update]

  resources :test_runs, except: %i[edit update destroy] do
    resources :test_model_version_runs, only: %i[show]
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
