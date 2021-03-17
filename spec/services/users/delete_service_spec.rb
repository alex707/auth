RSpec.describe Users::DeleteService do
  subject { described_class }

  let!(:user) { create(:user) }

  context 'valid parameters' do
    let(:user_params) do
      {
        id: user.id
      }
    end

    it 'delete an existing user' do
      expect {
        subject.call(user: user_params)
      }.to change { User.count }.by(-1)
    end
  end

  context 'invalid parameters' do
    let(:user_params) do
      {
        id: 9999999999
      }
    end

    it 'does not delete user' do
      expect {
        subject.call(user: user_params)
      }.not_to change { User.count }
    end
  end
end
