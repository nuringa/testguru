module GistsHelper
  def question_link(gist)
    link_text = gist.question.body.truncate(25)
    link_to link_text, admin_question_path(gist.question), target: :blank
  end

  def gist_link_with_hash(url)
    link_text = url.split('/').last
    link_to link_text, url, target: :blank
  end
end
