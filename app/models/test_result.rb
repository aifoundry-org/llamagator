# frozen_string_literal: true

class TestResult < ApplicationRecord
  belongs_to :test_model_version_run
  has_many :assertion_results, dependent: :destroy

  enum :status, { pending: 0, completed: 1, failed: 2 }, scopes: true, default: :pending

  delegate :model_version, to: :test_model_version_run

  default_scope { order(id: :desc) }
end
