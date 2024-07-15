require 'rails_helper'

RSpec.describe PromptsController, type: :controller do
  let(:user) { create(:user) }
  let(:prompt) { create(:prompt, user: user) }
  let(:model) { create(:model, user: user) }
  let(:model_version) { create(:model_version, model: model) }
  let!(:test_result) { create(:test_result, prompt: prompt, model_version: model_version) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "assigns @prompts" do
      get :index
      expect(assigns(:prompts)).to eq(user.prompts)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns @prompt and @test_results" do
      get :show, params: { id: prompt.id }
      expect(assigns(:prompt)).to eq(prompt)
      expect(assigns(:test_results)).to eq([test_result])
    end

    it "renders the show template" do
      get :show, params: { id: prompt.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns a new prompt" do
      get :new
      expect(assigns(:prompt)).to be_a_new(Prompt)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) { { prompt: attributes_for(:prompt) } }

      it "creates a new prompt" do
        expect {
          post :create, params: valid_params
        }.to change(Prompt, :count).by(1)
      end

      it "redirects to the created prompt" do
        post :create, params: valid_params
        expect(response).to redirect_to(prompt_url(Prompt.last))
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested prompt" do
      prompt # create the prompt before the expect block
      expect {
        delete :destroy, params: { id: prompt.id }
      }.to change(Prompt, :count).by(-1)
    end

    it "redirects to the prompts list" do
      delete :destroy, params: { id: prompt.id }
      expect(response).to redirect_to(prompts_url)
    end
  end
end
