class Comment < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :event
  belongs_to :user, optional: true

  validates :body, presence: true, length: { maximum: 1024 }
  validates :user_name, presence: true, length: { maximum: 39 }, unless: -> { user.present? }

  def user_name
    user&.name || super
  end
end
