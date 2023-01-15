class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:mailer, :email)
  layout "mailer"
end
