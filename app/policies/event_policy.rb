class EventPolicy < ApplicationPolicy
  def show?
    pincode_correct?(record)
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
    return true if event.pincode.blank? || user == event.user

    event.pincode_valid?(cookies.permanent["events_#{event.id}_pincode"])
  end
end
