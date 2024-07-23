# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestModelVersionRun, type: :model do
  let(:test_run) { create(:test_run) }
  let(:model_version) { create(:model_version) }
  let!(:test_model_version_run) { create(:test_model_version_run, test_run:, model_version:) }

  describe '.with_passed_test_results_count' do
    let!(:test_result1) { create(:test_result, test_model_version_run:, status: TestResult.statuses[:completed]) }
    let!(:test_result2) { create(:test_result, test_model_version_run:, status: TestResult.statuses[:completed]) }
    let!(:assertion_result1) { create(:assertion_result, test_result: test_result1, state: AssertionResult.states[:passed]) }
    let!(:assertion_result2) { create(:assertion_result, test_result: test_result2, state: AssertionResult.states[:passed]) }

    it 'returns records with correct test results count' do
      result = TestModelVersionRun.with_passed_test_results_count.find(test_model_version_run.id)

      expect(result.test_results_total_count).to eq(2)
      expect(result.passed_test_results_count).to eq(2)
    end

    context 'with no passed test results' do
      let(:test_result3) { create(:test_result, test_model_version_run:, status: TestResult.statuses[:completed]) }
      let!(:assertion_result3) { create(:assertion_result, test_result: test_result3, state: AssertionResult.states[:failed]) }
      it 'returns records with correct test results count' do
        result = TestModelVersionRun.with_passed_test_results_count.find(test_model_version_run.id)

        expect(result.test_results_total_count).to eq(3)
        expect(result.passed_test_results_count).to eq(2)
      end
    end
  end
end
