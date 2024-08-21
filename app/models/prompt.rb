# frozen_string_literal: true

class Prompt < ApplicationRecord
  has_ancestry
  belongs_to :user
  has_many :test_runs, dependent: :destroy
  has_many :test_results, through: :test_runs

  validates :name, presence: true, uniqueness: { scope: :user_id }

  scope :latest_versions, -> { joins("LEFT JOIN prompts AS c ON c.ancestry LIKE CONCAT('%/', prompts.id, '/%')").group('prompts.id').having('COUNT(c.id) = 0') }

  default_scope { order(id: :desc) }
end
