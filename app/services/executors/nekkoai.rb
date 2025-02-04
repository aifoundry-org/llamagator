# frozen_string_literal: true

module Executors
  class Nekkoai < Executors::Base
    def initialize(model_version)
      @client = Clients::NekkoaiClient.new(api_url: model_version.model.url, model: 'llama')
      super(model_version)
    end

    def call(prompt)
      model_version.model

      parameters = model_version.configuration.merge(messages: [{ role: 'user', content: prompt }])

      response = client.chat_completions(parameters)
      result = response['choices'].first['message']['content']

      { status: :completed, result: result.to_json.to_s }
    rescue StandardError => e
      return { status: :failed, result: e.response[:body].to_json.to_s } if e.respond_to?(:response)

      { status: :failed }
    end

    private

    attr_reader :client
  end
end
