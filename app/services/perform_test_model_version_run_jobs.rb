# frozen_string_literal: true

class PerformTestModelVersionRunJobs
  attr_reader :test_run_id, :test_model_version_run_id

  def initialize(test_run_id, test_model_version_run_id)
    @test_run_id = test_run_id
    @test_model_version_run_id = test_model_version_run_id
  end

  def call
    ApplicationRecord.transaction do
      break false if test_model_version_run.performed?

      jobs = Array.new(test_run.calls) { TestModelVersionRunJob.new(test_model_version_run.id) }
      SolidQueue::Job.enqueue_all(jobs)

      test_model_version_run.update(performed: true)
    end
  end

  def test_run
    @test_run ||= TestRun.find(test_run_id)
  end

  def test_model_version_run
    @test_model_version_run ||= test_run.test_model_version_runs.lock.find(test_model_version_run_id)
  end
end
