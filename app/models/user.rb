class User < ApplicationRecord
  has_many :test_passages, dependent: :delete_all
  has_many :tests, through: :test_passages
  has_many :author_tests, foreign_key: :author_id, class_name: 'Test', dependent: :destroy

  validates :name, presence: true

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def tests_by_level(level)
    tests.where(level: level)
  end
end
