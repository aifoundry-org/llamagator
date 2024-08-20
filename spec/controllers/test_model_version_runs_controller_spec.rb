# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestModelVersionRunsController, type: :controller do
  let(:user) { create(:user) }
  let(:prompt) { create(:prompt, user:) }
  let(:test_run) { create(:test_run, calls: 2, prompt:) }
  let(:model) { create(:model, user:) }
  let(:model_version) { create(:model_version, model:) }
  let(:test_model_version_run) { create(:test_model_version_run, test_run:, model_version:) }
  let(:test_results) { create_list(:test_result, 3, test_model_version_run:) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { test_run_id: test_run.id, id: test_model_version_run.id }
      expect(response).to be_successful
      expect(assigns(:test_results)).to match_array(test_model_version_run.test_results)
    end

    it 'returns the correct test_model_version_run' do
      get :show, params: { test_run_id: test_run.id, id: test_model_version_run.id }
      expect(assigns(:test_model_version_run)).to eq(test_model_version_run)
    end

    it 'returns the correct test_run' do
      get :show, params: { test_run_id: test_run.id, id: test_model_version_run.id }
      expect(assigns(:test_run)).to eq(test_run)
    end
  end

  describe 'POST #perform' do
    subject(:perform!) { post :perform, params: { test_run_id: test_run.id, id: test_model_version_run.id } }

    before do
      allow(SolidQueue::Job).to receive(:enqueue_all)
    end

    context 'with pending test_model_version_run' do
      it 'updates the performed attribute on test_model_version_run to true' do
        expect do
          perform!
          test_model_version_run.reload
        end.to change(test_model_version_run, :performed).to(true)
      end

      it 'enqueues a TestModelVersionRunJob' do
        perform!
        expect(SolidQueue::Job).to have_received(:enqueue_all).with(
          [
            have_attributes(class: TestModelVersionRunJob, arguments: [test_model_version_run.id]),
            have_attributes(class: TestModelVersionRunJob, arguments: [test_model_version_run.id])
          ]
        )
      end
    end

    context 'with already performed test_model_version_run' do
      let(:test_model_version_run) { create(:test_model_version_run, performed: true, test_run:, model_version:) }

      it 'does not enqueue a TestRunJob' do
        perform!
        expect(SolidQueue::Job).not_to have_received(:enqueue_all)
      end
    end
  end
end
