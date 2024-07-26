# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ModelsController, type: :controller do
  let(:user) { create(:user) }
  let(:model) { create(:model, user:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns @models' do
      get :index
      expect(assigns(:models)).to eq(user.models)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns @model and @model_versions' do
      get :show, params: { id: model.id }
      expect(assigns(:model)).to eq(model)
      expect(assigns(:model_versions)).to eq(model.model_versions)
    end

    it 'renders the show template' do
      get :show, params: { id: model.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new model' do
      get :new
      expect(assigns(:model)).to be_a_new(Model)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns @model' do
      get :edit, params: { id: model.id }
      expect(assigns(:model)).to eq(model)
    end

    it 'renders the edit template' do
      get :edit, params: { id: model.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { { model: attributes_for(:model) } }

      it 'creates a new model' do
        expect do
          post :create, params: valid_params
        end.to change(Model, :count).by(1)
      end

      it 'redirects to the created model' do
        post :create, params: valid_params
        expect(response).to redirect_to(Model.last)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated Name' } }

      it 'updates the requested model' do
        patch :update, params: { id: model.id, model: new_attributes }
        model.reload
        expect(model.name).to eq('Updated Name')
      end

      it 'redirects to the model' do
        patch :update, params: { id: model.id, model: new_attributes }
        expect(response).to redirect_to(model)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested model' do
      model # create the model before the expect block
      expect do
        delete :destroy, params: { id: model.id }
      end.to change(Model, :count).by(-1)
    end

    it 'redirects to the models list' do
      delete :destroy, params: { id: model.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
