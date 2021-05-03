class Consumer
  attr_reader :channel, :queue, :exchange

  def initialize()
    @channel = RabbitMq.consumer_channel
    @queue = channel.queue('auth', durable: true)
    @exchange = channel.default_exchange
  end

  def start
    queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
      payload = JSON(payload)

      session_uuid = JwtEncoder.decode(payload['token'])

      result = nil
      if session_uuid['uuid']
        result = Auth::FetchUserService.call(session_uuid['uuid'])
      end

      user_id = nil
      if result.success?
        user_id = result.user.id
      end

      ads_service = AdsService::RpcClient.fetch(properties.correlation_id)
      ads_service.user_id(user_id)

      channel.ack(delivery_info.delivery_tag)
    end
  end
end

consumer = Consumer.new.start
puts 'Consumer auth started'
loop { sleep 3 }
