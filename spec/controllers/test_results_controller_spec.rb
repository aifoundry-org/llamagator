# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestResultsController, type: :controller do
  let(:user) { create(:user) }
  let(:model) { create(:model, user:) }
  let(:model_version) { create(:model_version, model:) }
  let(:prompt) { create(:prompt, user:) }
  let!(:test_result) { create(:test_result, model_version:, prompt:) }

  before do
    sign_in user
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the test result' do
        patch :update, params: { id: test_result.id, test_result: { rating: 4 } }, format: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ 'success' => true, 'rating' => 4 })
        test_result.reload
        expect(test_result.rating).to eq(4)
      end
    end
  end

  describe 'GET #index' do
    let(:model_2) { create(:model, user:) }
    let(:model_version_2) { create(:model_version, model: model_2) }
    let(:prompt_2) { create(:prompt, user:) }
    let!(:test_result_2) { create(:test_result, model_version: model_version_2, prompt: prompt_2) }

    it 'returns all test_results' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(assigns(:test_results)).to match_array([test_result, test_result_2])
    end

    it 'filters test results by model_version_id and prompt_id' do
      get :index, params: { model_version_id: model_version.id, prompt_id: prompt.id }
      expect(response).to have_http_status(:ok)
      expect(assigns(:test_results)).to match_array([test_result])
    end
  end

  describe 'GET #show' do
    it 'assigns @test_result' do
      get :show, params: { id: test_result.id }
      expect(response).to have_http_status(:ok)
      expect(assigns(:test_result)).to eq(test_result)
    end
  end
end
