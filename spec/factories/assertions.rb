# frozen_string_literal: true

FactoryBot.define do
  factory :assertion do
    name { 'MyString' }
    assertion_type { :exclude }
    value { 'MyText' }
    user { nil }
  end
end
