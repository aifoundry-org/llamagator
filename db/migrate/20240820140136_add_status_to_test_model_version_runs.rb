# frozen_string_literal: true

class AddStatusToTestModelVersionRuns < ActiveRecord::Migration[7.1]
  def change
    create_enum :test_model_version_run_status, %w[pending performing performed failed]

    add_column :test_model_version_runs, :status, :test_model_version_run_status, default: 'pending', null: false
  end
end
