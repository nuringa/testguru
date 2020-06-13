class TestPassagesController < ApplicationController

  before_action :find_test_passage, only: %i[show update result gist]

  def show; end

  def result; end

  def gist
    result = GistService.new(@test_passage.current_question).call

    if result.success?
      create_gist(result.html_url)
      flash[:notice] = t('.success', link: view_context.link_to("#{t('.here')}", result.html_url))
    else
      flash[:alert] = t('.failure')
    end

    redirect_to @test_passage
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      awarded_badges = Awarder.new(@test_passage).call
      awarded_badges.each { |badge| current_user.badges << badge }

      session[:badges] = awarded_badges&.pluck(:name, :url)

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
