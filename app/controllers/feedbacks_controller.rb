class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.email = current_user.email

    if @feedback.valid?
      FeedbacksMailer.send_feedback(@feedback).deliver_now

      flash[:warning] = t('.success')
      redirect_to tests_path
    else
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :subject, :message)
  end
end
