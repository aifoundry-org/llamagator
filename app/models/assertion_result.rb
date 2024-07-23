# frozen_string_literal: true

class AssertionResult < ApplicationRecord
  belongs_to :assertion
  belongs_to :test_result
  enum :state, %i[passed failed], scopes: true

  default_scope { order(id: :desc) }
end
