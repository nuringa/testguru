class Answer < ApplicationRecord
  MAX_ANSWERS = 4

  belongs_to :question

  validate :validate_answers_count, on: :create

  scope :correct_answers, -> { where(correct: true) }

  private

  def validate_answers_count
    errors.add(:title, 'Too many Answers') if question.answers.count >= MAX_ANSWERS
  end
end
