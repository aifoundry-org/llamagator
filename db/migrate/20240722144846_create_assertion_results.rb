# frozen_string_literal: true

class CreateAssertionResults < ActiveRecord::Migration[7.1]
  def change
    create_table :assertion_results do |t|
      t.references :test_result, null: false, foreign_key: true
      t.references :assertion, null: false, foreign_key: true
      t.integer :state

      t.timestamps
    end
  end
end
