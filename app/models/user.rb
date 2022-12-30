class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :comments
  has_many :subscriptions

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [100, 100]
  end

  validates :name, presence: true, length: { maximum: 35 }

  before_validation :set_name, on: :create
  after_commit :link_subscriptions, on: :create

  private

  def set_name
    self.name = "Товарищ №#{rand(1000)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end
end
