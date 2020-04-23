class TestPassage < ApplicationRecord
  SUCCESS_PER_CENT = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_validation :before_validation_set_next_question, on: :update

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end

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
    test.questions.pluck(:id).sort.index(current_question.id) + 1
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def before_validation_set_next_question
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort unless answer_ids.nil?
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question_id).first
  end
end
