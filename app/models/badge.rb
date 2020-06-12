class Badge < ApplicationRecord

  BADGES_URLS = %w[
    https://cdn3.iconfinder.com/data/icons/flat-badges-vol1/100/44_-512.png
    https://cdn3.iconfinder.com/data/icons/flat-badges-vol1/100/67_-512.png
    https://cdn3.iconfinder.com/data/icons/flat-badges-vol1/100/66_-512.png
    https://cdn3.iconfinder.com/data/icons/flat-badges-vol1/100/64_-512.png
    https://cdn1.iconfinder.com/data/icons/scenarium-vol-9/128/034_award_achievement_reward_badge-256.png
    https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-3/60/011_117_strenght_arm_power_biceps-512.png
    https://cdn2.iconfinder.com/data/icons/unilite-shift-human-vol-1/60/011_048_avatar_man_student_bachelor-512.png https://cdn2.iconfinder.com/data/icons/unilite-shift-achievements-badges/60/028_022_badge_award_peace_dove-512.png
    https://cdn1.iconfinder.com/data/icons/unilite-shift-emoji/60/040_029_party_face_happy_emoji-512.png
  ].freeze

  RULE_VALUES = %i[
    first_try
    category
    level
    loser
  ].freeze

  has_many :badges_users, dependent: :delete_all
  has_many :users, through: :badges_users

  validates :name, :url, presence: true
  validates :rule_name, uniqueness: true
end
