class TestPassage < ApplicationRecord
  SUCCESS_PER_CENT = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_current_question

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)

    save!
  end

  def completed?
    current_question.nil?
  end

  def correct_per_cent
    (correct_questions.to_f / test.questions.count * 100).round
  end

  def successful?
    correct_per_cent >= SUCCESS_PER_CENT
  end

  def current_question_index
    test.questions.order(:id).index(current_question) + 1
  end

  private

  def before_validation_set_current_question
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort unless answer_ids.nil?
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    if current_question.present?
      test.questions.order(:id).where('id > ?', current_question_id).first
    else
      test.questions.first
    end
  end
end
