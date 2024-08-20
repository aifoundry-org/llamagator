# frozen_string_literal: true

class AddPerformedToTestModelVersionRun < ActiveRecord::Migration[7.1]
  def change
    add_column :test_model_version_runs, :performed, :boolean, null: false, default: false
  end
end
