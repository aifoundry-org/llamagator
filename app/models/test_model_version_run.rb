# frozen_string_literal: true

class TestModelVersionRun < ApplicationRecord
  belongs_to :test_run
  belongs_to :model_version
  has_many :test_results

  default_scope { order(id: :desc) }
end
