FactoryBot.define do
  factory :model do
    name { "Test Model" }
    url { "http://example.com" }
    executor_type { "base" }
    api_key { "apikey" }
    association :user
  end
end
