class TestResult < ApplicationRecord
  belongs_to :model_version
  belongs_to :prompt

  enum :status, [ :pending, :completed ], scopes: false, default: :pending
end
