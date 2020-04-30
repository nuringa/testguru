require 'digest/sha1'

class User < ApplicationRecord

  EMAIL = /\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  has_many :test_passages, dependent: :delete_all
  has_many :tests, through: :test_passages
  has_many :author_tests, foreign_key: :author_id, class_name: 'Test', dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL }

  has_secure_password

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test: test)
  end

  def tests_by_level(level)
    tests.where(level: level)
  end
end
