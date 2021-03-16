RSpec.describe UserRoutes, type: :routes do
  describe 'GET v1' do
    before do
      create_list(:user, 3)
    end

    it 'returns a collection of users' do
      get '/v1'

      expect(last_response.status).to eq(200)
      expect(response_body['data'].size).to eq(3)
    end
  end

  describe 'POST /v1' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/v1'

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:user_params) do
        {
          name: '',
          email: 'user@email.com',
          password: '1234567890q',
          password_confirmation: '1234567890q'
        }
      end

      it 'returns an error' do
        post '/v1', user: user_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Укажите имя',
            'source' => {
              'pointer' => '/data/attributes/name'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      let(:user_params) do
        {
          name: 'user_name',
          email: 'user@email.com',
          password: '1234567890q',
          password_confirmation: '1234567890q'
        }
      end

      let(:last_user) { User.last }

      it 'creates a new user' do
        expect { post '/v1', user: user_params }
          .to change { User.count }.from(0).to(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an user' do
        post '/v1', user: user_params

        expect(response_body['data']).to a_hash_including(
          'id' => last_user.id.to_s,
          'type' => 'user'
        )
      end
    end
  end
end
