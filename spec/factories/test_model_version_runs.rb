# frozen_string_literal: true

FactoryBot.define do
  factory :test_model_version_run do
    association :model_version, factory: :model_version
    association :test_run, factory: :test_run
  end
end
