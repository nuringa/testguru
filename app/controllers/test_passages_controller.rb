class TestPassagesController < ApplicationController

  before_action :find_test_passage, only: %i[show update result gist]

  def show; end

  def result; end

  def gist
    result = GistService.new(@test_passage.current_question).call

    flash_options = if result
                      url = result.html_url
                      create_gist(url)

                      { notice: t('.success', link: view_context.link_to("#{t('.here')}", url)) }
                    else
                      { alert: t('.failure') }
                    end

    redirect_to @test_passage, flash_options
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render 'show'
    end
  end

  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def create_gist(gist_url)
    current_user.gists.create(
      url: gist_url,
      user: current_user,
      question: @test_passage.current_question)
  end
end
