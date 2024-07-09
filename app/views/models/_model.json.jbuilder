json.extract! model, :id, :name, :url, :configuration, :created_at, :updated_at
json.url model_url(model, format: :json)
