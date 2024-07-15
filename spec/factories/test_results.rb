FactoryBot.define do
  factory :test_result do
    association :model_version, factory: :model_version
    association :prompt, factory: :prompt
  end
end
