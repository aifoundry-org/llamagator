# frozen_string_literal: true

class Prompt < ApplicationRecord
  belongs_to :user
  has_many :test_results, dependent: :destroy
end
