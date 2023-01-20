require 'rails_helper'

describe EventPolicy do
  let(:user) { create(:user) }

  subject { described_class }

  permissions :edit?, :update?, :destroy? do
    it 'allow access for event owner' do
      expect(subject).to permit(user, Event.new(user: user))
    end

    it 'forbid access to other user' do
      expect(subject).not_to permit(user, Event.new(user: User.new))
    end
  end
end
