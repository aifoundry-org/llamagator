# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ModelExecutor do
  describe '#call' do
    context "when executor type is 'openai'" do
      let(:model) { create(:model, executor_type: 'openai') }
      let(:model_version) { create(:model_version, model:) }
      let(:prompt) { 'Test prompt' }
      let(:executor_instance) { instance_double(Executors::Openai) }

      before do
        allow(Executors::Openai).to receive(:new).and_return(executor_instance)
        allow(executor_instance).to receive(:call).with(prompt).and_return({ result: 'Test result' })
      end

      it 'calls the OpenAI executor' do
        model_executor = ModelExecutor.new(model_version)
        expect(model_executor.call(prompt)).to eq({ result: 'Test result' })
      end
    end

    context "when executor type is 'base'" do
      let(:model) { create(:model, executor_type: 'base') }
      let(:model_version) { create(:model_version, model:) }
      let(:prompt) { 'Test prompt' }
      let(:executor_instance) { instance_double(Executors::Base) }

      before do
        allow(Executors::Base).to receive(:new).and_return(executor_instance)
        allow(executor_instance).to receive(:call).with(prompt).and_return({ result: 'Test result' })
      end

      it 'calls the default executor' do
        model_executor = ModelExecutor.new(model_version)
        expect(model_executor.call(prompt)).to eq({ result: 'Test result' })
      end
    end
  end
end
