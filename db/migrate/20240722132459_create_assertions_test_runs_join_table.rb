# frozen_string_literal: true

class CreateAssertionsTestRunsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :assertions, :test_runs do |t|
      t.index :assertion_id
      t.index :test_run_id
    end
  end
end
