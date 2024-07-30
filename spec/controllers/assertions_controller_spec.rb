# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssertionsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:assertion, user_id: user.id) }
  let(:assertion) { create(:assertion, user:) }

  before do
    sign_in user # Assuming you are using Devise for authentication
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: assertion.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Assertion' do
        expect do
          post :create, params: { assertion: valid_attributes }
        end.to change(Assertion, :count).by(1)
      end

      it 'redirects to the created assertion' do
        post :create, params: { assertion: valid_attributes }
        expect(response).to redirect_to(Assertion.last)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested assertion' do
      assertion = create(:assertion, user:)
      expect do
        delete :destroy, params: { id: assertion.to_param }
      end.to change(Assertion, :count).by(-1)
    end

    it 'redirects to the assertions list' do
      delete :destroy, params: { id: assertion.to_param }
      expect(response).to redirect_to(assertions_url)
    end
  end
end
