# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckAssertion do
  let(:model_version) { nil }
  let(:assertion) { build(:assertion, assertion_type:, value: assertion_value, model_version:) }
  let(:result) { 'This is a test result string that includes some expected values.' }
  let(:check_assertion) { described_class.new(assertion) }

  describe '#call' do
    context 'when assertion is of type include_all' do
      let(:assertion_type) { 'include_all' }

      context 'when all values are included in the result' do
        let(:assertion_value) { "test\nresult\nincludes" }

        it 'returns passed' do
          expect(check_assertion.call(result)).to eq('passed')
        end
      end

      context 'when not all values are included in the result' do
        let(:assertion_value) { "test\nresult\nmissing" }

        it 'returns failed' do
          expect(check_assertion.call(result)).to eq('failed')
        end
      end
    end

    context 'when assertion is of type exclude_all' do
      let(:assertion_type) { 'exclude_all' }

      context 'when none of the values are included in the result' do
        let(:assertion_value) { "missing\nvaluesmiss" }

        it 'returns passed' do
          expect(check_assertion.call(result)).to eq('passed')
        end
      end

      context 'when any value is included in the result' do
        let(:assertion_value) { "test\nresult\nincludes" }

        it 'returns failed' do
          expect(check_assertion.call(result)).to eq('failed')
        end
      end
    end

    context 'when assertion is of type include_any' do
      let(:assertion_type) { 'include_any' }

      context 'when any values are included in the result' do
        let(:assertion_value) { "test\nresult\nnotincludes" }

        it 'returns passed' do
          expect(check_assertion.call(result)).to eq('passed')
        end
      end

      context 'when all values not included in the result' do
        let(:assertion_value) { "tests\nresults\nmissing" }

        it 'returns failed' do
          expect(check_assertion.call(result)).to eq('failed')
        end
      end
    end

    context 'when assertion is of type model_version' do
      let(:model_version) { create(:model_version) }
      let(:assertion_type) { 'model_version' }
      let(:assertion_value) { 'return true if text equal zero' }
      let(:model_response) { { content: result }.to_json }
      let(:model_executor) { instance_double(ModelExecutor, call: { status: :completed, result: model_response }) }

      before do
        allow(ModelExecutor).to receive(:new).with(model_version).and_return(model_executor)
      end

      context 'when model returns true' do
        let(:result) { 'true' }

        it 'returns passed' do
          expect(check_assertion.call(result)).to eq('passed')
        end
      end

      context 'when model returns false' do
        let(:result) { 'false' }

        it 'returns failed' do
          expect(check_assertion.call(result)).to eq('failed')
        end
      end
    end

    context 'when assertion value is nil' do
      let(:assertion_type) { 'include_all' }
      let(:assertion_value) { nil }

      it 'returns failed' do
        expect(check_assertion.call(result)).to eq('failed')
      end
    end

    context 'when result is nil' do
      let(:assertion_type) { 'include_all' }
      let(:assertion_value) { "test\nresult" }
      let(:result) { nil }

      it 'returns failed' do
        expect(check_assertion.call(result)).to eq('failed')
      end
    end
  end
end
