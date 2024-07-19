# frozen_string_literal: true

class CreateTestModelVersionRuns < ActiveRecord::Migration[7.1]
  def change
    create_table :test_model_version_runs do |t|
      t.references :test_run, null: false, foreign_key: true
      t.references :model_version, null: false, foreign_key: true

      t.timestamps
    end
  end
end
