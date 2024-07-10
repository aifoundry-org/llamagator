json.extract! model_version, :id, :model_id, :configuration, :description, :built_on, :build_name, :created_at, :updated_at
json.url model_version_url(model_version, format: :json)
