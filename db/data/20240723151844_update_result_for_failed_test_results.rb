# frozen_string_literal: true

class UpdateResultForFailedTestResults < ActiveRecord::Migration[7.1]
  TestResult = Class.new(ActiveRecord::Base)

  def up
    TestResult.where(status: 2).find_each do |test_result|
      parsed_result = begin
        JSON.parse(test_result.result)
      rescue StandardError
        nil
      end

      test_result.update(result: { error: { message: test_result.result } }.to_json) unless parsed_result.present?
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
