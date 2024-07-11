class ModelExecutor
  attr_reader :model_version

  def initialize(model_version)
    @model_version = model_version
  end

  def call(prompt)
    model = model_version.model
    uri = URI.parse(model.url)
    header = {'Content-Type': 'application/json'}
    data = model_version.configuration.merge(prompt: prompt)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = data.to_json
    response = http.request(request)
    response.body
  end
end
