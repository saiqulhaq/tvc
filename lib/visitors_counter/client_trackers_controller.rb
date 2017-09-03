require_dependency 'application_controller'

module VisitorsCounter
  class ClientTrackersController < ::ApplicationController
    def on_open
      # $redis.hset(redis_channel, session.id.to_s, Time.zone.now.to_i)
      # MessageBus.publish('/view-topic', params[:id])
      render json: { subscribed: true, sessionId: 12323 }
    end

    # TODO manage connected user data
    # def on_connected
    # end

    def on_close
      $redis.hdel(redis_channel, session.id.to_s)
      MessageBus.publish('/view-topic', params[:id])
      render json: { unsubscribed: true, sessionId: session.id }
    end

    private
    def redis_channel(id = nil)
      return "#{CHANNEL_PREFIX_NAME}#{id}" if id
      "#{CHANNEL_PREFIX_NAME}#{params[:id]}"
    end
  end
end
