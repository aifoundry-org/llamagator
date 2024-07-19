# frozen_string_literal: true

json.extract! test_run, :id, :created_at, :updated_at
json.url prompt_url(test_run, format: :json)
