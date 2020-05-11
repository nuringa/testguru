module GistsHelper
  def question_link(gist)
    link_text = gist.question.body.truncate(25)
    link_to link_text, admin_question_path(gist.question), target: :blank
  end
end
