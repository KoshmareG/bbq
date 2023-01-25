class EventPolicy < ApplicationPolicy
  def show?
    edit? || pincode_correct?(record)
  end

  def new?
    create?
  end

  def create?
    user.present?
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

  class Scope < Scope
    def resolve
      scope.all
    end
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
