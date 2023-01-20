require 'rails_helper'

describe EventPolicy do
  let(:user) { User.new }

  subject { described_class }

  permissions :edit? do
    it 'allow edit event' do
      expect(subject).to permit(user, Event.new(user: user))
    end

    it 'bot allow edit event' do
      expect(subject).not_to permit(user, Event.new(user: User.new))
    end
  end
end
