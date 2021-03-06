class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', optional: true
  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :delete_all
  has_many :users, through: :test_passages

  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :easy_level, -> { where(level: 0..1) }
  scope :medium_level, -> { where(level: 2..4) }
  scope :advanced_level, -> { where(level: 5..Float::INFINITY) }
  scope :from_category, (lambda do |name|
    joins(:category).where(categories: { name: name }).order(title: :desc)
  end)

  def self.title_from_category(name)
    from_category(name).pluck(:title)
  end
end
