# frozen_string_literal: true

class AddPassingThresholdToTestRuns < ActiveRecord::Migration[7.1]
  def change
    add_column :test_runs, :passing_threshold, :float, default: 0
  end
end
