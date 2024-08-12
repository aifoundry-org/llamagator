# frozen_string_literal: true

class AddResultToAssertionResult < ActiveRecord::Migration[7.1]
  def change
    add_column :assertion_results, :result, :json
  end
end
