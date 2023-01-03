class EventMailer < ApplicationMailer
  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: "#{t('.subscription.new_subscription')} #{event.title}"
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "#{t('.comment.new_comment')} #{event.title}"
  end

  def photo(event, photo, email)
    @event = event
    @photo = photo
    @photo_url =
      Rails.application.routes.url_helpers.rails_blob_url(
        photo.photo.variant(resize_to_fit: [500, 500])
      )

    mail to: email, subject: "Новое фото в #{event.title}"
  end
end
