class Question < ApplicationRecord
  belongs_to :test
  has_many :aswers
end
