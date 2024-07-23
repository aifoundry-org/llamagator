# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_many :models, dependent: :destroy
  has_many :model_versions, through: :models
  has_many :prompts, dependent: :destroy
  has_many :test_results, through: :prompts
  has_many :test_runs, through: :prompts
  has_many :assertions, dependent: :destroy

  default_scope { order(id: :desc) }
end
