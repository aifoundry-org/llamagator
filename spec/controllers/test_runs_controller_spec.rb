# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestRunsController, type: :controller do
  let(:user) { create(:user) }
  let(:prompt) { create(:prompt, user:) }
  let(:model) { create(:model, user:) }
  let(:model_version) { create(:model_version, model:) }
  let!(:test_run) { create(:test_run, prompt:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    let(:prompt_2) { create(:prompt, user:) }

    let!(:test_run_2) { create(:test_run, prompt: prompt_2) }

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(assigns(:test_runs)).to match_array([test_run, test_run_2])
    end

    it 'filters test results by prompt_id' do
      get :index, params: { prompt_id: prompt.id }
      expect(response).to be_successful
      expect(assigns(:test_runs)).to match_array([test_run])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: test_run.id }
      expect(response).to be_successful
      expect(assigns(:test_model_version_runs)).to eq(test_run.test_model_version_runs.includes(model_version: :model))
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { prompt_id: prompt.id }
      expect(response).to be_successful
      expect(assigns(:prompt)).to eq(prompt)
      expect(assigns(:prompts)).to eq(user.prompts)
      expect(assigns(:model_versions)).to eq(user.model_versions.includes(:model))
      expect(assigns(:test_run)).to be_a_new(TestRun)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) do
        {
          prompt_id: prompt.id,
          calls: 5,
          model_version_ids: [model_version.id]
        }
      end

      it 'creates a new TestRun' do
        expect do
          post :create, params: { test_run: valid_attributes }
        end.to change(TestRun, :count).by(1)
      end

      it 'enqueues a TestRunJob' do
        expect(SolidQueue::Job).to receive(:enqueue).exactly(1).time do |job_instance|
          expect(job_instance.class).to eq(TestRunJob)
          expect(job_instance.arguments).to include(TestRun.reorder(:created_at).last.id)
        end
        post :create, params: { test_run: valid_attributes }
      end

      it 'redirects to the created test run' do
        post :create, params: { test_run: valid_attributes }
        expect(response).to redirect_to(test_run_url(TestRun.reorder(:created_at).last))
        expect(flash[:notice]).to eq('Test model version run was successfully created.')
      end

      it 'responds with JSON for the created test run' do
        post :create, params: { test_run: valid_attributes }, format: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(test_run_url(TestRun.reorder(:created_at).last))
      end

      context 'with manual_execution param' do
        before do
          valid_attributes[:manual_execution] = '1'
          allow(SolidQueue::Job).to receive(:enqueue)
        end

        it 'does not enqueue a TestRunJob' do
          post :create, params: { test_run: valid_attributes }
          expect(SolidQueue::Job).not_to have_received(:enqueue)
        end
      end
    end
  end
end
