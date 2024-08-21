# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestModelVersionRunJobsController, type: :controller do
  let(:user) { create(:user) }
  let(:prompt) { create(:prompt, user:) }
  let(:test_run) { create(:test_run, calls: 2, prompt:) }
  let(:model) { create(:model, user:) }
  let(:model_version) { create(:model_version, model:) }
  let(:test_model_version_run) { create(:test_model_version_run, test_run:, model_version:) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    subject(:create!) { post :create, params: { test_run_id: test_run.id, test_model_version_run_id: test_model_version_run.id } }

    before do
      allow(SolidQueue::Job).to receive(:enqueue_all)
    end

    context 'with pending test_model_version_run' do
      it 'updates the performed attribute on test_model_version_run to true' do
        expect do
          create!
          test_model_version_run.reload
        end.to change(test_model_version_run, :status).to('performed')
      end

      it 'enqueues a TestModelVersionRunJob' do
        create!
        expect(SolidQueue::Job).to have_received(:enqueue_all).with(
          [
            have_attributes(class: TestModelVersionRunJob, arguments: [test_model_version_run.id]),
            have_attributes(class: TestModelVersionRunJob, arguments: [test_model_version_run.id])
          ]
        )
      end
    end

    context 'with already performed test_model_version_run' do
      let(:test_model_version_run) { create(:test_model_version_run, status: 'performed', test_run:, model_version:) }

      it 'does not enqueue a TestRunJob' do
        create!
        expect(SolidQueue::Job).not_to have_received(:enqueue_all)
      end
    end
  end
end
