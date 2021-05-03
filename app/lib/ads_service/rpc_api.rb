module AdsService
  module RpcApi
    def user_id(user_id)
      payload = { user_id: user_id }.to_json
      publish(payload, type: 'user_id')
    end
  end
end
