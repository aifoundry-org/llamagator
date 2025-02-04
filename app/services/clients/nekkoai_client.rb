# frozen_string_literal: true

module Clients
  class NekkoaiClient
    attr_reader :api_url, :model

    def initialize(api_url:, model:)
      @api_url = api_url
      @model = model
    end

    def chat_completions(payload)
      uri = URI(api_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')

      request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
      request.body = payload.to_json

      response = http.request(request)
      JSON.parse(response.body)
    end
  end
end
