# frozen_string_literal: true

FactoryBot.define do
  factory :test_result do
    association :test_model_version_run, factory: :test_model_version_run
  end
end
