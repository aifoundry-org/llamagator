# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestRunJob, type: :job do
  let(:user) { create(:user) }
  let(:model) { create(:model, user:) }
  let(:model_version) { create(:model_version, model:) }
  let(:prompt) { create(:prompt, user:) }
  let(:test_run) { create(:test_run, prompt:) }
  let(:test_model_version_run) { create(:test_model_version_run, test_run:, model_version:) }

  describe '#perform' do
    it 'creates a TestResult and updates it with model execution result' do
      expect(TestModelVersionRun).to receive(:find).with(test_model_version_run.id).and_return(test_model_version_run)

      model_executor_instance = instance_double(ModelExecutor)
      allow(ModelExecutor).to receive(:new).with(model_version).and_return(model_executor_instance)
      allow(model_executor_instance).to receive(:call).with(prompt.value).and_return({ accuracy: 0.95 })

      expect(TestResult).to receive(:create).with(test_model_version_run:).and_call_original

      expect_any_instance_of(TestResult).to receive(:update).with({ accuracy: 0.95, time: instance_of(Float) })

      TestModelVersionRunJob.perform_now(test_model_version_run.id)
    end
  end
end
