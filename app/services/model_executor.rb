class ModelExecutor
  attr_reader :model_version

  def initialize(model_version)
    @model_version = model_version
  end

  def call(text)
    model = model_version.model
    uri = URI.parse(model.url)
    header = {'Content-Type': 'application/json'}
    data = model_version.configuration.merge(prompt: "This is a conversation between User and OLMo<|endoftext|>\n\nUser:\n" + text + "\n OLMo: ")

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = data.to_json
    response = http.request(request)
    JSON.parse(response.body)["content"].to_s
  end
end
