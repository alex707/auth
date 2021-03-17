RSpec.describe Users::UpdateService do
  subject { described_class }

  let!(:user) { create(:user) }

  context 'valid parameters' do
    let(:user_params) do
      {
        id: user.id,
        name: 'User_name2',
        email: 'user2@email.com',
        password: '12342',
        password_confirmation: '12342'
      }
    end

    it 'updates an existing user' do
      expect {
        subject.call(user: user_params)
      }.to_not change { User.count }
    end
  end

  context 'invalid parameters' do
    let(:user_params) do
      {
        id: user.id,
        name: 'User_name2',
        email: '',
        password: '12342',
        password_confirmation: '12342'
      }
    end

    it 'does not update user' do
      expect {
        subject.call(user: user_params)
      }.not_to change { User.count }
    end
  end
end
