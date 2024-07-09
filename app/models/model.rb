class Model < ApplicationRecord
  validate :configuration_is_json
  before_save :parse_configuration

  belongs_to :user

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
