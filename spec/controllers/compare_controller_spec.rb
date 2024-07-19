# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompareController, type: :controller do
  let(:user) { create(:user) }
  let(:prompt1) { create(:prompt, user:) }
  let(:prompt2) { create(:prompt, user:) }
  let(:model) { create(:model, user:) }
  let(:model_version_1) { create(:model_version, model:) }
  let(:model_version_2) { create(:model_version, model:) }
  let(:test_run) { create(:test_run) }
  let(:test_model_version_run) { create(:test_model_version_run, test_run:, model_version: model_version_1) }
  let!(:test_result) { create(:test_result, test_model_version_run:, status: 'completed') }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @prompts and @model_versions' do
      get :index
      expect(assigns(:prompts)).to match_array([prompt1, prompt2])
      expect(assigns(:model_versions)).to match_array([model_version_1, model_version_2])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #model_versions' do
    it 'returns the model versions associated with the given test run and completed test results' do
      get :model_versions, params: { test_run_id: test_run.id }
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json_response).to be_an(Array)
      expect(json_response.size).to eq(1)
      expect(json_response.first['id']).to eq(model_version_1.id)
    end

    it 'returns an empty array if no model versions match the criteria' do
      get :model_versions, params: { test_run_id: create(:test_run).id }
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json_response).to be_an(Array)
      expect(json_response).to be_empty
    end
  end
end
