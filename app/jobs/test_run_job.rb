class TestRunJob < ApplicationJob
  def perform(model_version_id, prompt_id)
    ActiveRecord::Base.transaction do
      model_version = ModelVersion.find(model_version_id)
      prompt = Prompt.find(prompt_id)

      test_result = TestResult.create(model_version: model_version, prompt: prompt)

      result = {}

      benchmark = Benchmark.measure do
        result = ModelExecutor.new(model_version).call(prompt.value)
      end

      spent_time = benchmark.real

      test_result.update(result.merge(time: spent_time))
    end
  end
end
