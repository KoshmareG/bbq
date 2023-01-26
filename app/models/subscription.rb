class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_email, presence: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { user.present? }
  validates :user_name, presence: true, length: { maximum: 39 }, unless: -> { user.present? }
  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }
  validate :not_self_subscription
  validate :email_uniqueness

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def not_self_subscription
    errors.add(:user, :taken, message: I18n.t('subscriptions.error')) if event.user == user ||
      event.user.email == user_email
  end

  def email_uniqueness
    unless user.present?
      errors.add(:user, :taken) unless User.find_by(email: user_email).nil?
    end
  end
end
