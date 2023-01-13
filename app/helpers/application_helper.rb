module ApplicationHelper
  def user_avatar(user)
    if user.avatar.attached?
      user.avatar.variant(resize_to_fill: [400, 400])
    else
      asset_path('default_avatar.png')
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.attached?
      user.avatar.variant(:thumb)
    else
      asset_path('default_avatar.png')
    end
  end

  def event_photo(event)
    photos = event.photos.includes(photo_attachment: :blob).persisted

    if photos.any?
      url_for(photos.sample.photo)
    else
      asset_path('event.jpg')
    end
  end

  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      url_for(photos.sample.photo_thumb)
    else
      asset_path('event_thumb.jpg')
    end
  end
end
