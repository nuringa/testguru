class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.default_email
  layout 'mailer'
end
