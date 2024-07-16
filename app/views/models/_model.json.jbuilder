json.extract! model, :id, :name, :url, :executor_type, :created_at, :updated_at
json.url model_url(model, format: :json)
