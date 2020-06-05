class ApplicationMailer < ActionMailer::Base

  if Rails.env.production?
    default from: ENV['FROM_DEFAULT']
  else
    default from: Rails.application.credentials.default_email
  end

  layout 'mailer'
end
