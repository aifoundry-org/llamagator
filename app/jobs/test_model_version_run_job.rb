# frozen_string_literal: true

class TestModelVersionRunJob < ApplicationJob
  attr_reader :test_model_version_run, :test_result

  def perform(test_model_version_run_id)
    @test_model_version_run = TestModelVersionRun.find(test_model_version_run_id)
    model_version = test_model_version_run.model_version
    prompt = test_model_version_run.test_run.prompt

    @test_result = TestResult.create(test_model_version_run:)

    result = {}
    benchmark = Benchmark.measure do
      result = ModelExecutor.new(model_version).call(prompt.value)
    end

    spent_time = benchmark.real

    test_result.update(result.merge(time: spent_time))

    generate_assertion_results
  end

  private

  def generate_assertion_results
    test_run = test_model_version_run.test_run

    test_run.assertions.each do |assertion|
      state = CheckAssertion.new(assertion).call(test_result.content)

      test_result.assertion_results.create(assertion:, state:)
    end
  end
end
