# frozen_string_literal: true

FactoryBot.define do
  factory :prompt do
    value { 'Default Value' }
    name { 'Default Name' }
    association :user, factory: :user
  end
end