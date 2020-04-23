class Answer < ApplicationRecord
  MAX_ANSWERS = 4

  belongs_to :question

  validate :validate_answers_count, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def validate_answers_count
    if question.answers.present?
      errors.add(:title, 'Too many Answers') if question.answers.count >= MAX_ANSWERS
    end
  end
end
