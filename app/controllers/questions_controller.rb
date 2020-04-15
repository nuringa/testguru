class QuestionsController < ApplicationController
  before_action :find_test, only: :create
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.build(question_params)

    if @question.save
      render plain: "Question was successfully created"
    else
      render 'new'
    end
  end

  def show
  end

  def destroy
    @question.destroy
    render plain: "Successfully deleted the question"
  end

  private

  def find_test
    @test = Test.find(1)
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: 'Question not found.'
  end

  def question_params
    params.require(:question).permit(:body, :test_id).merge(test_id: 1)
  end
end
