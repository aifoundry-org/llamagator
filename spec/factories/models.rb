# frozen_string_literal: true

FactoryBot.define do
  factory :model do
    name { 'Test Model' }
    url { 'http://example.com' }
    executor_type { 'llama_cpp' }
    api_key { 'apikey' }
    association :user
  end
end
