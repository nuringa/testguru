module QuestionsHelper
  def question_header
    "#{ self.action_name.capitalize } Test \"#{@test.title.capitalize}\" Question"
  end
end