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

  def visitors
    subscribers + [user]
  end
end
