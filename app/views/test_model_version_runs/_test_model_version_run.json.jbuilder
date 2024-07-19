# frozen_string_literal: true

json.extract! test_model_version_run, :id, :test_run_id, :model_version_id, :created_at, :updated_at
json.url test_model_version_run_url(test_model_version_run, format: :json)
