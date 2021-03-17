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


  describe 'GET /v1/:id' do
    context 'missing parameters' do
      it 'returns an error' do
        get '/v1/:id'

        expect(last_response.status).to eq(404)
      end
    end

    context 'invalid parameters' do
      let(:user_params) do
        {
          id: 9999999999
        }
      end

      it 'returns an error' do
        get '/v1/:id', user: user_params

        expect(last_response.status).to eq(404)
      end
    end

    context 'valid parameters' do
      before do
        create_list(:user, 2)
      end

      let(:user_params) do
        {
          id: User.last.id
        }
      end

      it 'returns an a user' do
        get '/v1/:id', user: user_params

        expect(last_response.status).to eq(200)
        expect(response_body['data']['id'].to_i).to eq user_params[:id]
      end
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

      it 'returns an a user' do
        post '/v1', user: user_params

        expect(response_body['data']).to a_hash_including(
          'id' => last_user.id.to_s,
          'type' => 'user'
        )
      end
    end
  end

  describe 'PUT /v1' do
    let!(:user) { create(:user) }

    context 'missing parameters' do
      it 'returns an error' do
        put '/v1'

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:user_params) do
        {
          id: user.id,
          name: '',
          email: 'user@email.com',
          password: '1234567890q',
          password_confirmation: '1234567890q'
        }
      end

      it 'returns an error' do
        put '/v1', user: user_params

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
          id: user.id,
          name: 'user2_name',
          email: 'user2@email.com',
          password: '1234567890q',
          password_confirmation: '1234567890q'
        }
      end

      let!(:last_user) { User.last }

      it 'updates an existing user' do
        expect { put '/v1', user: user_params }
          .to_not change { User.count }

        expect(last_response.status).to eq(201)
      end

      it 'returns an a user' do
        put '/v1', user: user_params

        expect(response_body['data']).to a_hash_including(
          'id' => last_user.id.to_s,
          'attributes' => {
            "name"=>user_params[:name],
            "email"=>user_params[:email]
          },
          'type' => 'user'
        )
      end
    end
  end

  describe 'DELETE /v1' do
    context 'missing parameters' do
      it 'returns an error' do
        delete '/v1'

        expect(last_response.status).to eq(404)
      end
    end

    context 'invalid parameters' do
      let(:user_params) do
        {
          id: 9999999999
        }
      end

      it 'returns an error' do
        delete '/v1', user: user_params

        expect(last_response.status).to eq(404)
      end
    end

    context 'valid parameters' do
      before do
        create_list(:user, 2)
      end

      let(:user_params) do
        {
          id: User.last.id
        }
      end

      it 'deletes an a user' do
        expect { delete '/v1', user: user_params }
          .to change { User.count }.by(-1)

        expect(last_response.status).to eq(201)
      end
    end
  end
end
