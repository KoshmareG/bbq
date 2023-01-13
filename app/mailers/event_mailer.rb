class EventMailer < ApplicationMailer
  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: "#{t('.subscription.new_subscription')} \"#{event.title}\""
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "#{t('.comment.new_comment')} \"#{event.title}\""
  end

  def photo(event, photo, email)
    @event = event
    @photo = photo

    mail to: email, subject: "#{t('.photo.new_photo')} \"#{event.title}\""
  end
end
