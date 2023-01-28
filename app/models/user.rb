class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github yandex]

  has_many :events
  has_many :comments
  has_many :subscriptions

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [100, 100]
  end

  validates :name, presence: true, length: { maximum: 39 }
  validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif']

  before_validation :downcase_email
  before_validation :set_name, on: :create
  after_commit :link_subscriptions, on: :create

  def self.find_for_oauth(access_token)
    email = access_token.info.email.downcase
    user = where(email: email).first

    return user if user.present?

    name = access_token.extra.raw_info.login
    provider = access_token.provider

    case
    when provider == 'github'
      avatar_url = access_token.extra.raw_info.avatar_url
      url = access_token.extra.raw_info.url
    when provider == 'yandex'
      avatar_url = "https://avatars.mds.yandex.net/get-yapic/#{access_token.extra.raw_info.default_avatar_id}/islands-300"
      url = access_token.extra.raw_info.id
    end

    where(url: url, provider: provider).first_or_create! do |user|
      user.email = email
      user.name = name
      user.password = Devise.friendly_token.first(16)
      user.avatar.attach(io: URI.open(avatar_url), filename: "#{name}_avatar") if avatar_url.present?
    end
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  private

  def set_name
    self.name = "Товарищ №#{rand(1000)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end

  def downcase_email
    email&.downcase!
  end
end
