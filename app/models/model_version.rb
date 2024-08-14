# frozen_string_literal: true

class ModelVersion < ApplicationRecord
  belongs_to :model
  has_many :test_model_version_runs, dependent: :destroy
  has_many :test_results, through: :test_model_version_runs
  has_many :assertions, dependent: :destroy
  validate :configuration_is_json
  before_save :parse_configuration
  delegate :executor_type, to: :model
  delegate :api_key, to: :model

  default_scope { order(id: :desc) }

  def as_json(options = {})
    options[:methods] ||= [:full_name]
    super
  end

  def full_name
    "#{model.name} #{build_name}"
  end

  def content_path
    CONTENT_PATHS[executor_type]
  end

  private

  CONTENT_PATHS = {
    'openai' => ['choices', 0, 'message', 'content'],
    'ollama' => [0, 'response'],
    'llama_cpp' => ['content']
  }.freeze

  def configuration_is_json
    return unless configuration.present? && !configuration.is_a?(Hash)

    JSON.parse(configuration)
  rescue JSON::ParserError
    errors.add(:configuration, 'must be valid JSON')
  end

  def parse_configuration
    self.configuration = JSON.parse(configuration) if configuration.is_a?(String) && !configuration.empty?
  end
end
