module QuestionsHelper
  def question_header(question, test = nil)
    if question.new_record?
      "Create Test \"#{test.title.capitalize}\" Question"
    else
      "Edit Test \"#{question.test.title.capitalize}\" Question"
    end

  end
end
