class User < ApplicationRecord

  EMAIL = /\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  has_many :test_passages, dependent: :delete_all
  has_many :tests, through: :test_passages
  has_many :author_tests, foreign_key: :author_id, class_name: 'Test', dependent: :destroy
  has_many :gists, dependent: :destroy
  has_many :badges_users, dependent: :delete_all
  has_many :badges, through: :badges_users

  validates :first_name, presence: true

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :trackable,
         :confirmable

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test: test)
  end

  def tests_by_level(level)
    tests.where(level: level)
  end

  def admin?
    is_a?(Admin)
  end
end
