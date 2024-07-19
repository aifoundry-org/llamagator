# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestModelVersionRunsController, type: :controller do
  let(:user) { create(:user) }
  let(:prompt) { create(:prompt, user:) }
  let(:test_run) { create(:test_run, prompt:) }
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
end
