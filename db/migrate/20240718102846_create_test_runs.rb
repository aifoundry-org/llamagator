# frozen_string_literal: true

class CreateTestRuns < ActiveRecord::Migration[7.1]
  def change
    create_table :test_runs do |t|
      t.references :prompt, null: false, foreign_key: true
      t.integer :calls, default: 1

      t.timestamps
    end
  end
end
