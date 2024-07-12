class Executors::Openai < Executors::Base
  def initialize(model_version)
    @client = OpenAI::Client.new(access_token: model_version.api_key, log_errors: true )
    super(model_version)
  end

  def call(prompt)
    model = model_version.model

    parameters = model_version.configuration.merge(messages: [{ role: "user", content: prompt }])

    result = client.chat(parameters: parameters)

    { status: :completed, result: result.to_s }
  rescue => e
    return { status: :failed, result: e.response.to_s } if e.respond_to?(:response)

    { status: :failed }
  end

  private

  attr_reader :client
end
