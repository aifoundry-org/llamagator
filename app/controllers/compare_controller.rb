class CompareController < ApplicationController
  before_action :set_prompt

  def index
    @model_versions = current_user.model_versions.includes(:model)
  end

  private

  def set_prompt
    @prompt = current_user.prompts.find(params[:prompt_id])
  end
end
