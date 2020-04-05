class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :tests_users
  has_many :author_tests, foreign_key: :author_id, class_name: 'Test'

  def tests_by_level(level)
    Test.joins('JOIN tests_users ON tests_users.test_id = tests.id')
        .where(level: level, tests_users: { user_id: id })
  end
end
