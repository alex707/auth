RSpec.describe UserSerializer do
  subject { described_class.new([user], links: links) }

  let(:user) { create(:user) }

  let(:links) do
    {
      first: '/path/to/first/page',
      last: '/path/to/last/page',
      next: '/path/to/next/page'
    }
  end

  let(:attributes) do
    user.values.select do |attr|
      %i[
        name
        email
      ].include?(attr)
    end
  end

  it 'returns user representation' do
    expect(subject.serializable_hash).to a_hash_including(
      data: [
        {
          id: user.id.to_s,
          type: :user,
          attributes: attributes
        }
      ],
      links: links
    )
  end
end
