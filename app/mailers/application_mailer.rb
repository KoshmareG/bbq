class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILBOX_EMAIL']
  layout "mailer"
end
