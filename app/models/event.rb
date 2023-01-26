class Event < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photos, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :datetime, presence: true
  validates :description, presence: true, length: { maximum: 512 }
  validates :pincode, numericality: { only_integer: true }, length: { in: 4..6 }, allow_blank: true

  def visitors
    subscribers + [user]
  end

  def pincode_valid?(user_pincode)
    pincode == user_pincode
  end
end
