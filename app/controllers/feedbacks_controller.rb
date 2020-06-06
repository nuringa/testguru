class FeedbacksController < ApplicationController

  skip_before_action :authenticate_user!

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)

    current_user.present? ? @feedback.email = current_user.email : @feedback_email = feedback_params[:email]

    if @feedback.valid?
      FeedbacksMailer.send_feedback(@feedback).deliver_now

      flash[:warning] = t('.success')

      current_user.present? ? redirect_to(tests_path) : redirect_to(new_user_session_path)

    else
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :subject, :message)
  end
end
