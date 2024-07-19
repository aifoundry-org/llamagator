# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestRunJob, type: :job do
  let(:test_run) { create(:test_run, calls: 3) }
  let!(:test_model_version_run) { create(:test_model_version_run, test_run:) }

  describe '#perform' do
    it 'enqueues TestModelVersionRunJob for each test_model_version_run the specified number of times' do
      expect(SolidQueue::Job).to receive(:enqueue).exactly(test_run.calls).times do |job_instance|
        expect(job_instance.class).to eq(TestModelVersionRunJob)
        expect(job_instance.arguments).to include(test_model_version_run.id)
      end

      TestRunJob.perform_now(test_run.id)
    end
  end
end
