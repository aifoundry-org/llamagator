# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Executors::Openai do
  let(:model) { create(:model, api_key: 'test_api_key') }
  let(:model_version) { create(:model_version, model:, configuration: { param: 'value' }) }
  let(:executor) { Executors::Openai.new(model_version) }
  let(:prompt) { 'Test prompt' }

  describe '#initialize' do
    it 'initializes with an OpenAI client' do
      expect(executor.instance_variable_get(:@client)).to be_an_instance_of(OpenAI::Client)
    end
  end

  describe '#call' do
    context 'when OpenAI API call is successful' do
      before do
        allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return({ response: 'Chat response' })
      end

      it 'returns a completed status with result on successful response' do
        expect(executor.call(prompt)).to eq({ status: :completed, result: '{"response":"Chat response"}' })
      end
    end

    context 'when OpenAI API call raises an error' do
      before do
        allow_any_instance_of(OpenAI::Client).to receive(:chat).and_raise(Faraday::ClientError.new('API error',
                                                                                                   body: { error_message: 'API error' }))
      end

      it 'returns a failed status with error result' do
        expect(executor.call(prompt)).to eq({ status: :failed, result: '{"error_message":"API error"}' })
      end
    end
  end
end
