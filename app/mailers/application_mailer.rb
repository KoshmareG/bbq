class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.mailbox[:email]
  layout "mailer"
end
