# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestRunJob, type: :job do
  let(:test_run) { create(:test_run, calls: 2) }
  let!(:test_model_version_run) { create(:test_model_version_run, test_run:) }

  describe '#perform' do
    subject(:perform!) { TestRunJob.perform_now(test_run.id) }

    before do
      allow(SolidQueue::Job).to receive(:enqueue_all)
    end

    it 'updates the performed attribute on test_model_version_run to true' do
      expect do
        perform!
        test_model_version_run.reload
      end.to change(test_model_version_run, :status).to('performed')
    end

    it 'enqueues TestModelVersionRunJob for each test_model_version_run the specified number of times' do
      perform!

      expect(SolidQueue::Job).to have_received(:enqueue_all).with(
        [
          have_attributes(class: TestModelVersionRunJob, arguments: [test_model_version_run.id]),
          have_attributes(class: TestModelVersionRunJob, arguments: [test_model_version_run.id])
        ]
      )
    end
  end
end
