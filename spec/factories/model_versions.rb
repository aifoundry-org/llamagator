# frozen_string_literal: true

FactoryBot.define do
  factory :model_version do
    configuration { {} }
    description { 'Default Description' }
    built_on { Date.today }
    build_name { 'Default Build' }
    association :model, factory: :model
  end
end
