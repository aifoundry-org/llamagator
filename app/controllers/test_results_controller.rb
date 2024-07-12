class TestResultsController < ApplicationController
  before_action :set_test_result, only: :update

  def update
    if @test_result.update(test_results_params)
      render json: { success: true, rating: @test_result.rating }, status: :ok
    else
      render json: { success: false, errors: @test_result.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    test_results = current_user.test_results.order(created_at: :desc)

    test_results = test_results.where(model_version_id: params[:model_version_id], prompt_id: params[:prompt_id]) if params[:model_version_id].present? && params[:prompt_id].present?

    render json: test_results
  end

  private

  def set_test_result
    @test_result = current_user.test_results.find(params[:id])
  end

  def test_results_params
    params.require(:test_result).permit(:rating)
  end
end
