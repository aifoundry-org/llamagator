# frozen_string_literal: true

class AssertionResult < ApplicationRecord
  belongs_to :assertion
  belongs_to :test_result
  enum :state, { passed: 0, failed: 1 }, scopes: true

  default_scope { order(id: :desc) }
end
