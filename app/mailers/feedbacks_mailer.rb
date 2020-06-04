class FeedbacksMailer < ApplicationMailer

  def send_feedback(feedback)
    @email = feedback.email
    @message = feedback.message
    @subject = feedback.subject

    mail from: @email,
         cc: @email,
         to:  Rails.application.credentials.default_email,
         subject: "TestGuru feedback: #{@subject}",
         body: @message
  end
end
