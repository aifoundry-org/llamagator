class ModelVersion < ApplicationRecord
  belongs_to :model
  has_many :test_results, dependent: :destroy
  validate :configuration_is_json
  before_save :parse_configuration
  delegate :executor_type, to: :model
  delegate :api_key, to: :model

  def full_name
    "#{model.name} #{build_name}"
  end

  private

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
