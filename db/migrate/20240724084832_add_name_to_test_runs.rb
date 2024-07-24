# frozen_string_literal: true

class AddNameToTestRuns < ActiveRecord::Migration[7.1]
  def change
    add_column :test_runs, :name, :string
  end
end
