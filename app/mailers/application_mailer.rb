class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.app_email
  layout "mailer"
end
