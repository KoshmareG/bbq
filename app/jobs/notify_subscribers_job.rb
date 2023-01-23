class NotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(record)
    EventMailer.subscription(record.event, record).deliver_later if record.class == Subscription

    if record.class == Photo || record.class == Comment
      all_emails =
        (record.event.subscriptions.map(&:user_email) + [record.event.user.email] - [record.user&.email])

      case
      when record.class == Photo
        all_emails.each { |email| EventMailer.photo(record.event, record, email).deliver_later }
      when record.class == Comment
        all_emails.each { |email| EventMailer.comment(record.event, record, email).deliver_later }
      end
    end
  end
end
