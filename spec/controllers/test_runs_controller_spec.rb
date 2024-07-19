# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestRunsController, type: :controller do
  let(:user) { create(:user) }
  let(:prompt) { create(:prompt, user:) }
  let(:model_1) { create(:model, user:) }
  let(:model_2) { create(:model, user:) }
  let(:model_version1) { create(:model_version, model: model_1) }
  let(:model_version2) { create(:model_version, model: model_2) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns @model_versions' do
      get :new, params: { prompt_id: prompt.id }
      expect(response).to have_http_status(:ok)
      expect(assigns(:model_versions)).to match_array(user.model_versions.includes(:model))
    end
  end

  describe 'POST #create' do
    it 'creates test run jobs for selected model versions' do
      model_version_ids = [model_version1.id, model_version2.id]
      post :create, params: { prompt_id: prompt.id, model_version_ids: }

      expect(SolidQueue::Job).to receive(:enqueue).exactly(model_version_ids.size).times do |job_instance|
        expect(job_instance.class).to eq(TestRunJob)
        expect(job_instance.arguments).to include(model_version_ids.shift.to_s)
        expect(job_instance.arguments).to include(prompt.id)
      end

      post :create, params: { prompt_id: prompt.id, model_version_ids: }

      expect(response).to redirect_to(prompt_path(prompt))
    end
  end
end
