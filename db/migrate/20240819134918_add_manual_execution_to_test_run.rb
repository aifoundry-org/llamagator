# frozen_string_literal: true

class AddManualExecutionToTestRun < ActiveRecord::Migration[7.1]
  def change
    add_column :test_runs, :manual_execution, :boolean, null: false, default: false
  end
end
