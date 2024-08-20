# frozen_string_literal: true

class PerformTestModelVersionRunJobs
  attr_reader :test_run, :test_model_version_run_id

  def initialize(test_run, test_model_version_run_id)
    @test_run = test_run
    @test_model_version_run_id = test_model_version_run_id
  end

  def call
    ApplicationRecord.transaction do
      return false if test_model_version_run.performed?

      test_model_version_run.update(status: 'performing')
    end

    jobs = Array.new(test_run.calls) { TestModelVersionRunJob.new(test_model_version_run.id) }
    ActiveJob.perform_all_later(jobs)

    test_model_version_run.update(status: 'performed')
  end

  def test_model_version_run
    @test_model_version_run ||= test_run.test_model_version_runs.lock.find(test_model_version_run_id)
  end
end
