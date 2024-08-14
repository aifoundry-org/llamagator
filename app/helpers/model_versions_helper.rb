# frozen_string_literal: true

module ModelVersionsHelper
  DEFAULT_CONFIGURATION = {
    'openai' => '{"model":"gpt-3.5-turbo","temperature":0.5}',
    'ollama' => '{"model":"llama3.1"}',
    'llama' => '{"n_predict":500,"temperature":0.5,"stop":["<|end|>","<|user|>","<|assistant|>","<|endoftext|>","<|system|>"]}'
  }.freeze

  def default_configuration(executor_type)
    DEFAULT_CONFIGURATION[executor_type] || {}.to_json
  end
end
