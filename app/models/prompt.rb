# frozen_string_literal: true

class Prompt < ApplicationRecord
  belongs_to :user
  has_many :test_runs, dependent: :destroy
  has_many :test_results, through: :test_runs

  default_scope { order(id: :desc) }
end
