# frozen_string_literal: true

json.array! @model_versions, partial: 'model_versions/model_version', as: :model_version
