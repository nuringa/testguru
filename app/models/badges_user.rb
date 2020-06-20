class BadgesUser < ApplicationRecord
  belongs_to :user
  belongs_to :badge
  belongs_to :test_passage, optional: true
end
