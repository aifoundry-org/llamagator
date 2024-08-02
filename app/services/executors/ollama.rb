# frozen_string_literal: true

module Executors
  class Ollama < Base
    private

    SPLIT_JSON_OBJECTS_REGEXP = /(?<=\})\n(?=\{)/

    def process_response(response_body)
      response_body.split(SPLIT_JSON_OBJECTS_REGEXP).map { |value| JSON.parse(value) }.to_json
    end
  end
end
