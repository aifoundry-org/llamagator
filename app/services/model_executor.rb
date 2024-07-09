class ModelExecutor
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def call(text)
    uri = URI.parse(model.url)
    header = {'Content-Type': 'application/json'}
    data = model.configuration.merge(prompt: "This is a conversation between User and OLMo<|endoftext|>\n\nUser:\n" + text + "\n OLMo: ")

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = data.to_json
    response = http.request(request)
    JSON.parse(response.body)["content"].to_s
  end
end
