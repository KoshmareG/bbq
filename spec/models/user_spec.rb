require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.find_for_github_oauth' do
    let(:access_token) do
      double(
        :access_token,
        provider: 'github',
        info: double(email: 'test@example.com'),
        extra: double(raw_info: double(login: 'username', url: 'https://api.github.com/users/username'))
      )
    end

    context 'when user is not found' do
      it 'returns newly created user' do
        user = User.find_for_github_oauth(access_token)

        expect(user).to be_persisted
        expect(user.email).to eq('test@example.com')
      end
    end

    context 'when user is found by email' do
      let!(:existing_user) { create(:user, email: 'test@example.com') }
      let!(:some_other_user) { create(:user) }

      it 'returns this user' do
        expect(User.find_for_github_oauth(access_token)).to eq(existing_user)
      end
    end

    context 'when user is found by provider & url' do
      let!(:existing_user) { create(:user, provider: 'github', url: 'https://api.github.com/users/username') }
      let!(:some_other_user) { create(:user) }

      it 'returns newly created user' do
        expect(User.find_for_github_oauth(access_token)).to eq(existing_user)
      end
    end
  end
end
