# frozen_string_literal: true

class AndTestModelVersionRunToTestResults < ActiveRecord::Migration[7.1]
  def change
    add_reference :test_results, :test_model_version_run, index: true, foreign_key: true
  end
end
