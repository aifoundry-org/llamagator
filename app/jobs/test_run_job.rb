# frozen_string_literal: true

class TestRunJob < ApplicationJob
  def perform(test_run_id)
    test_run = TestRun.find(test_run_id)

    jobs = test_run.test_model_version_run_ids.flat_map do |test_model_version_run_id|
      Array.new(test_run.calls) { TestModelVersionRunJob.new(test_model_version_run_id) }
    end

    ActiveJob.perform_all_later(jobs)
  end
end
