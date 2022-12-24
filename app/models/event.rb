class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :address, presence: true
  validates :description, presence: true
end
