class NotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(record)
    all_emails =
      (record.event.subscriptions.map(&:user_email) + [record.event.user.email] - [record.user&.email])

    case record
    when Subscription
      EventMailer.subscription(record.event, record).deliver_later
    when Photo
      all_emails.each { |email| EventMailer.photo(record.event, record, email).deliver_later }
    when Comment
      all_emails.each { |email| EventMailer.comment(record.event, record, email).deliver_later }
    end
  end
end
