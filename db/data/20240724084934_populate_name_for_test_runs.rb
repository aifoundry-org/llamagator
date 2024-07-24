# frozen_string_literal: true

class PopulateNameForTestRuns < ActiveRecord::Migration[7.1]
  TestRun = Class.new(ActiveRecord::Base)

  def up
    TestRun.update_all("name = to_char(created_at, 'Mon DD, YYYY HH12:MI PM')")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
