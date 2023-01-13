class Comment < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :event
  belongs_to :user, optional: true

  validates :body, presence: true
  validates :user_name, presence: true, unless: -> { user.present? }

  def user_name
    user&.name || super
  end
end
