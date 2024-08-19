# frozen_string_literal: true

Rails.application.routes.draw do
  resources :assertions, except: %i[edit update]
  resources :test_runs
  resources :prompts do
    member do
      get 'diff/:prompt_version_id', action: :diff, as: :diff
    end
  end

  resources :test_runs, except: %i[edit update destroy] do
    resources :test_model_version_runs, only: %i[show] do
      post :perform, on: :member
    end
  end

  resources :compare, only: [:index] do
    collection do
      get :model_versions
    end
  end

  resources :test_results, only: %i[index update show] do
    resources :assertion_results, only: %i[index]
  end

  resources :models do
    resources :model_versions
  end
  devise_for :users

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'dashboard#index'
end
