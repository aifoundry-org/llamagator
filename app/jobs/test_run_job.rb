# frozen_string_literal: true

class TestRunJob < ApplicationJob
  def perform(test_run_id)
    test_run = TestRun.find(test_run_id)

    test_run.test_model_version_run_ids.each do |test_model_version_run_id|
      PerformTestModelVersionRunJobs.new(test_run, test_model_version_run_id).call
    end
  end
end
