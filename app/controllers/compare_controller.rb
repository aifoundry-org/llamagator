class CompareController < ApplicationController
  def index
    @prompts = current_user.prompts
    @model_versions = current_user.model_versions.includes(:model)
  end
end
