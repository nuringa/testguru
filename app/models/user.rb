class User < ApplicationRecord
  has_many :tests_users, dependent: :delete_all
  has_many :tests, through: :tests_users
  has_many :author_tests, foreign_key: :author_id, class_name: 'Test', dependent: :destroy

  validates :name, presence: true

  def tests_by_level(level)
    tests.where(level: level)
  end
end
