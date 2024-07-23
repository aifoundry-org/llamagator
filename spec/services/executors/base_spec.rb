# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Executors::Base do
  describe '#call' do
    let(:model) { create(:model, url: 'http://example.com/model_endpoint') }
    let(:model_version) { create(:model_version, model:, configuration: { param: 'value' }) }
    let(:executor) { Executors::Base.new(model_version) }
    let(:prompt) { 'Test prompt' }

    context 'when HTTP request is successful' do
      before do
        stub_request(:post, 'http://example.com/model_endpoint')
          .with(
            body: '{"param":"value","prompt":"Test prompt"}',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: '{"response": "Test response"}', headers: {})
      end

      it 'returns a completed status with result on successful response' do
        expect(executor.call(prompt)).to eq({ status: :completed, result: '{"response": "Test response"}' })
      end
    end

    context 'when HTTP request fails' do
      before do
        stub_request(:post, 'http://example.com/model_endpoint')
          .to_return(status: 500, body: 'Internal Server Error')
      end

      it 'returns a failed status' do
        expect(executor.call(prompt)).to eq({ status: :failed, result: 'Internal Server Error' })
      end
    end

    context 'when HTTP request times out' do
      before do
        stub_request(:post, 'http://example.com/model_endpoint')
          .to_timeout
      end

      it 'returns a failed status' do
        expect(executor.call(prompt)).to eq({ result: { error: { message: 'execution expired' } }.to_json, status: :failed })
      end
    end
  end
end
