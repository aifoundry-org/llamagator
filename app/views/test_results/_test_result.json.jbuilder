# frozen_string_literal: true

json.extract! test_result, :id, :result, :time, :rating, :status, :content, :created_at, :updated_at
json.url test_result_url(test_result, format: :json)
