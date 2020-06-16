class Badge < ApplicationRecord

  has_many :badges_users, dependent: :delete_all
  has_many :users, through: :badges_users

  validates :name, :url, presence: true
  validates :rule_name, presence: true, uniqueness: { scope: :rule_value }
  validates_inclusion_of :rule_name, in: %w[first_try category level loser]
end
