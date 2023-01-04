class Event < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photos

  validates :title, presence: true, length: { maximum: 255 }
  validates :address, presence: true
  validates :datetime, presence: true
  validates :description, presence: true
  validates :pincode, numericality: { only_integer: true }, length: { in: 4..6 }

  def visitors
    subscribers + [user]
  end

  def pincode_valid?(user_pincode)
    pincode == user_pincode
  end
end
