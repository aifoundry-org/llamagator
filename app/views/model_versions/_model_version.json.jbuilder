json.extract! model_version, :id, :model_id, :configuration, :description, :built_on, :build_name, :created_at, :updated_at
json.url model_model_version_url(id: model_version.id, format: :json)
