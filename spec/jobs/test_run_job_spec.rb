# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestRunJob, type: :job do
  let(:user) { create(:user) }
  let(:model) { create(:model, user:) }
  let(:model_version) { create(:model_version, model:) }
  let(:prompt) { create(:prompt, user:) }

  describe '#perform' do
    it 'creates a TestResult and updates it with model execution result' do
      expect(ModelVersion).to receive(:find).with(model_version.id).and_return(model_version)
      expect(Prompt).to receive(:find).with(prompt.id).and_return(prompt)

      model_executor_instance = instance_double(ModelExecutor)
      allow(ModelExecutor).to receive(:new).with(model_version).and_return(model_executor_instance)
      allow(model_executor_instance).to receive(:call).with(prompt.value).and_return({ accuracy: 0.95 })

      expect(TestResult).to receive(:create).with(model_version:, prompt:).and_call_original

      expect_any_instance_of(TestResult).to receive(:update).with({ accuracy: 0.95, time: instance_of(Float) })

      TestRunJob.perform_now(model_version.id, prompt.id)
    end
  end
end
