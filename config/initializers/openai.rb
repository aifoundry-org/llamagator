openai_credentials = Rails.application.credentials&.openai

return unless openai_credentials && openai_credentials.access_token && openai_credentials.organization_id

OpenAI.configure do |config|
  config.access_token =  openai_credentials.access_token
  config.organization_id = openai_credentials.organization_id
end
