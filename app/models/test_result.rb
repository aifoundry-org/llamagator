class TestResult < ApplicationRecord
  belongs_to :model_version
  belongs_to :prompt

  enum :status, [ :pending, :completed, :failed ], scopes: true, default: :pending

  def content
    return '' if pending?

    return JSON.parse(result).dig("error", "message") if failed?

    return JSON.parse(result).dig("choices", 0, "message", "content") if model_version.executor_type == 'openai'

    return JSON.parse(result)['content'] if completed?
  rescue
    ''
  end
end
