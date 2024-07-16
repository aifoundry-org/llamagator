# frozen_string_literal: true

credentials = begin
  Rails.application.credentials
rescue StandardError
  nil
end

if credentials.present? && !(credentials.dig(:active_record_encryption, :primary_key) &&
       credentials.dig(:active_record_encryption, :deterministic_key) &&
       credentials.dig(:active_record_encryption, :key_derivation_salt))
  new_keys = {
    active_record_encryption: {
      primary_key: SecureRandom.hex(16),
      deterministic_key: SecureRandom.hex(16),
      key_derivation_salt: SecureRandom.hex(16)
    }
  }

  encrypted = ActiveSupport::EncryptedConfiguration.new(
    config_path: 'config/credentials.yml.enc',
    key_path: 'config/master.key',
    env_key: 'RAILS_MASTER_KEY',
    raise_if_missing_key: true
  )

  current_credentials = YAML.load(encrypted.read) || {}
  updated_credentials = current_credentials.deep_merge(new_keys)
  encrypted.write(updated_credentials.to_yaml)
end
