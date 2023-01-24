class EventPolicy < ApplicationPolicy
  def show?
    edit? || pincode_correct?(record)
  end

  def edit?
    user_is_owner?(record)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  private

  def user_is_owner?(event)
    user.present? && (event.try(:user) == user)
  end

  def pincode_correct?(event)
    return true if event.pincode.blank?

    event.pincode_valid?(cookies["events_#{event.id}_pincode"])
  end
end
