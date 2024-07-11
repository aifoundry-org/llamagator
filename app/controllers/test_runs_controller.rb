class TestRunsController < ApplicationController
  before_action :set_prompt

  def new
    @model_versions = current_user.model_versions.includes(:model)
  end

  def create
    model_version_ids = params['model_version_ids'].select(&:present?)

    model_version_ids.each do |model_version_id|
      TestRunJob.perform_later(model_version_id, @prompt.id)
    end

    redirect_to prompt_path(@prompt)
  end

  private

  def set_prompt
    @prompt = current_user.prompts.find(params[:prompt_id])
  end
end
