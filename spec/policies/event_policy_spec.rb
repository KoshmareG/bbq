require 'rails_helper'

describe EventPolicy do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let(:event) { create(:event, user: user) }
  let(:event_w_pincode) { create(:event, user: user, pincode: '1234') }

  let(:user_w_context) { UserContext.new(user) }
  let(:other_user_w_context) { UserContext.new(other_user) }

  let(:user_w_correct_pincode) { UserContext.new(other_user, { "events_#{event_w_pincode.id}_pincode" => event_w_pincode.pincode }) }
  let(:user_w_incorrect_pincode) { UserContext.new(other_user, { "events_#{event_w_pincode.id}_pincode" => '123' }) }

  subject { described_class }

  context 'user can edit update destroy own event' do
    permissions :edit?, :update?, :destroy? do
      it 'allow access for event owner' do
        expect(subject).to permit(user_w_context, event)
      end
    end
  end

  context 'user can not edit update destroy foreign event' do
    permissions :edit?, :update?, :destroy? do
      it 'forbid access to other user' do
        expect(subject).not_to permit(other_user_w_context, event)
      end
    end
  end

  context 'show event without pincode' do
    permissions :show? do
      it 'allow access' do
        expect(subject).to permit(other_user_w_context, event)
      end
    end
  end

  context 'show event with pincode' do
    permissions :show? do
      it 'event owner see event without pincode' do
        expect(subject).to permit(user_w_context, event_w_pincode)
      end

      it 'user with correct pincode can see event' do
        expect(subject).to permit(user_w_correct_pincode, event_w_pincode)
      end

      it 'user with incorrect pincode not see event' do
        expect(subject).not_to permit(user_w_incorrect_pincode, event_w_pincode)
      end
    end
  end

  context 'user can create new event' do
    permissions :new?, :create? do
      it 'allow access' do
        expect(subject).to permit(user_w_context, Event.new)
      end

      it 'forbids access' do
        expect(subject).not_to permit(Event.new)
      end
    end
  end
end
