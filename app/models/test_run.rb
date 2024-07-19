# frozen_string_literal: true

class TestRun < ApplicationRecord
  belongs_to :prompt
  has_many :test_model_version_runs, dependent: :destroy
  has_many :model_versions, through: :test_model_version_runs
  has_many :test_results, through: :test_model_version_runs

  accepts_nested_attributes_for :test_model_version_runs, allow_destroy: true
end
