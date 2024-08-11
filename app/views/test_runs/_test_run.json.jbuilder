# frozen_string_literal: true

json.extract! test_run, :id, :name, :created_at, :updated_at
json.test_result_ids test_run.test_result_ids
json.url prompt_url(test_run, format: :json)
