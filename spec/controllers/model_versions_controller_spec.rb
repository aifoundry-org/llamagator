require 'rails_helper'

RSpec.describe ModelVersionsController, type: :controller do
  let(:user) { create(:user) }
  let(:model) { create(:model, user: user) }
  let(:model_version) { create(:model_version, model: model) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "assigns @model_versions" do
      get :index, params: { model_id: model.id }
      expect(assigns(:model_versions)).to eq(model.model_versions)
    end

    it "renders the index template" do
      get :index, params: { model_id: model.id }
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns @model_version" do
      get :show, params: { model_id: model.id, id: model_version.id }
      expect(assigns(:model_version)).to eq(model_version)
    end

    it "renders the show template" do
      get :show, params: { model_id: model.id, id: model_version.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns a new model version" do
      get :new, params: { model_id: model.id }
      expect(assigns(:model_version)).to be_a_new(ModelVersion)
    end

    it "renders the new template" do
      get :new, params: { model_id: model.id }
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "assigns @model_version" do
      get :edit, params: { model_id: model.id, id: model_version.id }
      expect(assigns(:model_version)).to eq(model_version)
    end

    it "renders the edit template" do
      get :edit, params: { model_id: model.id, id: model_version.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) { { model_version: attributes_for(:model_version) } }

      it "creates a new model version" do
        expect {
          post :create, params: { model_id: model.id, model_version: valid_params[:model_version] }
        }.to change(ModelVersion, :count).by(1)
      end

      it "redirects to the created model version" do
        post :create, params: { model_id: model.id, model_version: valid_params[:model_version] }
        expect(response).to redirect_to(model_model_version_url(model, ModelVersion.last))
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { model_version: attributes_for(:model_version, configuration: 'invalid json') } }

      it "does not create a new model version" do
        expect {
          post :create, params: { model_id: model.id, model_version: invalid_params[:model_version] }
        }.to_not change(ModelVersion, :count)
      end

      it "renders the new template" do
        post :create, params: { model_id: model.id, model_version: invalid_params[:model_version] }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) { { description: "Updated Description" } }

      it "updates the requested model version" do
        patch :update, params: { model_id: model.id, id: model_version.id, model_version: new_attributes }
        model_version.reload
        expect(model_version.description).to eq("Updated Description")
      end

      it "redirects to the model version" do
        patch :update, params: { model_id: model.id, id: model_version.id, model_version: new_attributes }
        expect(response).to redirect_to(model_model_version_url(model, model_version))
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { { configuration: 'invalid json' } }

      it "does not update the model version" do
        patch :update, params: { model_id: model.id, id: model_version.id, model_version: invalid_attributes }
        expect(model_version.reload.configuration).to_not be_nil
      end

      it "renders the edit template" do
        patch :update, params: { model_id: model.id, id: model_version.id, model_version: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested model version" do
      model_version # create the model version before the expect block
      expect {
        delete :destroy, params: { model_id: model.id, id: model_version.id }
      }.to change(ModelVersion, :count).by(-1)
    end

    it "redirects to the model versions list" do
      delete :destroy, params: { model_id: model.id, id: model_version.id }
      expect(response).to redirect_to(model_model_versions_url(model))
    end
  end
end
