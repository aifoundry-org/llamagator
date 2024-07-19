# frozen_string_literal: true

class TestModelVersionRunJob < ApplicationJob
  def perform(test_model_version_run_id)
    test_model_version_run = TestModelVersionRun.find(test_model_version_run_id)
    model_version = test_model_version_run.model_version
    prompt = test_model_version_run.test_run.prompt

    test_result = TestResult.create(test_model_version_run:)

    result = {}
    benchmark = Benchmark.measure do
      result = ModelExecutor.new(model_version).call(prompt.value)
    end

    spent_time = benchmark.real

    test_result.update(result.merge(time: spent_time))
  end
end
