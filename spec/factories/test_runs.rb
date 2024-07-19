# frozen_string_literal: true

FactoryBot.define do
  factory :test_run do
    calls { 1 }
    association :prompt, factory: :prompt
  end
end
