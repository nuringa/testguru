class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :tests_users
  has_many :users, through: :tests_users
  belongs_to :author, class_name: 'User', optional: true

  def self.from_category(category_name)
    Test.joins('JOIN categories ON categories.id = tests.category_id')
        .where(categories: { name: category_name }).order(title: :desc).pluck(:title)
  end
end
