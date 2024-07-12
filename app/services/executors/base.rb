class Executors::Base
  attr_reader :model_version

  def initialize(model_version)
    @model_version = model_version
  end

  def call(prompt)
    model = model_version.model
    uri = URI.parse(model.url)
    header = {'Content-Type': 'application/json'}
    data = model_version.configuration.merge(prompt: "This is a conversation between User and OLMo<|endoftext|>\n\nUser:\n#{prompt}\n OLMo: ")

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = data.to_json
    http.read_timeout = 2000
    response = http.request(request)

    return { status: :completed, result: response.body } if response.code.to_i == 200

    { status: :failed, result: response.body }
  rescue
    { status: :failed }
  end
end