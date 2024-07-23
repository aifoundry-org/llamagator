# frozen_string_literal: true

class TestModelVersionRun < ApplicationRecord
  belongs_to :test_run
  belongs_to :model_version
  has_many :test_results

  default_scope { order(id: :desc) }

  scope :with_passed_test_results_count, lambda {
    left_joins(test_results: :assertion_results)
      .select(
        sanitize_sql_array(['test_model_version_runs.*,
         COUNT(DISTINCT test_results.id) AS test_results_total_count,
         COUNT(DISTINCT (CASE
           WHEN (test_results.status = :test_result_status AND (
              NOT EXISTS (
              SELECT 1
              FROM assertion_results
              WHERE assertion_results.test_result_id = test_results.id
              AND assertion_results.state <> :assertion_result_state
            )
            ))
           THEN test_results.id
           END)) AS passed_test_results_count',
                            { test_result_status: TestResult.statuses[:completed], assertion_result_state: AssertionResult.states[:passed] }])
      )
      .group('test_model_version_runs.id')
  }
end
