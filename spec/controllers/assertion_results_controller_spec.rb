# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssertionResultsController, type: :controller do
  let(:user) { create(:user) }
  let(:prompt) { create(:prompt, user:) }
  let(:test_run) { create(:test_run, prompt:) }
  let(:model) { create(:model, user:) }
  let(:model_version) { create(:model_version, model:) }
  let(:test_model_version_run) { create(:test_model_version_run, test_run:, model_version:) }
  let(:test_result) { create(:test_result, test_model_version_run:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: { test_result_id: test_result.id }, format: :json
      expect(response).to be_successful
    end

    it 'sets the correct test_result' do
      get :index, params: { test_result_id: test_result.id }, format: :json
      expect(assigns(:test_result)).to eq(test_result)
    end

    it 'sets the correct assertion_results' do
      get :index, params: { test_result_id: test_result.id }, format: :json
      expect(assigns(:assertion_results)).to eq(test_result.assertion_results)
    end
  end
end
