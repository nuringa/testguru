class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', optional: true
  has_many :questions, dependent: :destroy
  has_many :tests_users, dependent: :delete_all
  has_many :users, through: :tests_users


  def self.from_category(category_name)
    Test.joins(:category)
        .where(categories: { name: category_name }).order(title: :desc).pluck(:title)
  end
end
