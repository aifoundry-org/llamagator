# frozen_string_literal: true

json.extract! assertion, :id, :name, :assertion_type, :value, :user_id, :created_at, :updated_at
json.url assertion_url(assertion, format: :json)
