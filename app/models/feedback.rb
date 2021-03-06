class Feedback
  include ActiveModel::Model

  attr_accessor :name, :email, :subject, :message

  validates :name, presence: true, length: { in: 5..100 }
  validates :subject, presence: true, length: { in: 5..255 }
  validates :message, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
