class TestRunJob < ApplicationJob
  def perform(model_version_id, prompt)
    model_version = ModelVersion.find(model_version_id)

    test_result = TestResult.create(model_version: model_version, prompt: prompt)

    result = ''

    benchmark = Benchmark.measure do
      result = ModelExecutor.new(model_version).call(prompt.value)
    end

    spent_time = benchmark.real

    test_result.update(time: spent_time, result: result, status: :completed)
  end
end
