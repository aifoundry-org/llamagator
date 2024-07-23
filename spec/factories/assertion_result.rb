# frozen_string_literal: true

FactoryBot.define do
  factory :assertion_result do
    association :test_result, factory: :test_result
    association :assertion, factory: :assertion
  end
end
