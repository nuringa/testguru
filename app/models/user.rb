class User < ApplicationRecord

  def tests_by_level(level)
    Test.joins('JOIN tests_users ON tests_users.test_id = tests.id')
        .where(level: level, tests_users: { user_id: self.id })
  end
end
