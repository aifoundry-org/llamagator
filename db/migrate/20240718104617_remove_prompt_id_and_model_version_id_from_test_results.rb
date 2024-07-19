# frozen_string_literal: true

class RemovePromptIdAndModelVersionIdFromTestResults < ActiveRecord::Migration[7.1]
  def up
    TestResult.find_each do |test_result|
      test_run = TestRun.create(prompt_id: test_result.prompt_id)
      test_model_version_run = TestModelVersionRun.create(test_run:, model_version_id: test_result.model_version_id)
      test_result.update(test_model_version_run_id: test_model_version_run.id)
    end

    remove_reference :test_results, :prompt, index: true
    remove_reference :test_results, :model_version, index: true
  end

  def down
    add_reference :test_results, :prompt, index: true, foreign_key: true
    add_reference :test_results, :model_version, index: true, foreign_key: true

    TestResult.find_each do |test_result|
      test_model_version_run = test_result.test_model_version_run
      test_run = test_model_version_run.test_run
      test_result.update(prompt_id: test_run.prompt_id, model_version_id: test_model_version_run.model_version_id)
    end
  end
end
