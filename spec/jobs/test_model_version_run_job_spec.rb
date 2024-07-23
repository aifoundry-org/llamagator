# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestModelVersionRunJob, type: :job do
  let(:assertions) { create_list(:assertion, 3) }
  let(:test_run) { create(:test_run, assertion_ids: assertions.map(&:id)) }
  let(:test_model_version_run) { create(:test_model_version_run, test_run:) }
  let(:model_version) { test_model_version_run.model_version }
  let(:prompt) { test_run.prompt }
  let(:test_result) { create(:test_result, test_model_version_run:) }
  let(:model_executor) { instance_double(ModelExecutor, call: { result: 'success' }) }
  let(:check_assertion) { instance_double(CheckAssertion, call: 'passed') }

  before do
    allow(TestModelVersionRun).to receive(:find).and_return(test_model_version_run)
    allow(TestResult).to receive(:create).and_return(test_result)
    allow(ModelExecutor).to receive(:new).with(model_version).and_return(model_executor)
    allow(Benchmark).to receive(:measure).and_yield.and_return(double(real: 0.123))
    allow(test_result).to receive(:update)
    allow(test_result.assertion_results).to receive(:create)
  end

  describe '#perform' do
    it 'finds the test model version run by id' do
      expect(TestModelVersionRun).to receive(:find).with(test_model_version_run.id)
      described_class.new.perform(test_model_version_run.id)
    end

    it 'creates a new test result for the test model version run' do
      expect(TestResult).to receive(:create).with(test_model_version_run:)
      described_class.new.perform(test_model_version_run.id)
    end

    it 'executes the model with the prompt' do
      expect(ModelExecutor).to receive(:new).with(model_version).and_return(model_executor)
      expect(model_executor).to receive(:call).with(prompt.value)
      described_class.new.perform(test_model_version_run.id)
    end

    it 'updates the test result with the execution result and time spent' do
      expect(test_result).to receive(:update).with(hash_including(result: 'success', time: 0.123))
      described_class.new.perform(test_model_version_run.id)
    end

    it 'generates assertion results' do
      assertions.each do |assertion|
        expect(CheckAssertion).to receive(:new).with(assertion).and_return(check_assertion)
        expect(test_result.assertion_results).to receive(:create).with(assertion:, state: 'passed')
      end
      described_class.new.perform(test_model_version_run.id)
    end
  end
end
