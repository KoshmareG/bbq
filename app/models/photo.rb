class Photo < ApplicationRecord
  scope :persisted, -> { where 'id IS NOT NULL' }

  belongs_to :event
  belongs_to :user

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_fill: [140, 140]
  end

  validates :photo, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif']
end
