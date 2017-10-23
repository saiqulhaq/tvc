module VisitorsCounter
  class Tracker
    attr_reader :visited_pages

    def initialize(topic_id)
      @topic_id = topic_id.to_i
    end

    def valid?
      topic_id.positive?
    end

    def visit(new_visitors = 1)
      # $redis.hset(redis_channel, session.id.to_s, Time.zone.now.to_i)
      # MessageBus.publish('/view-topic', params[:id])
    end

    def leaving
      $redis.hdel(redis_channel, session.id.to_s)
    end

    def publish
      MessageBus.publish('/view-topic', params[:id])
    end

    private
    def redis_channel(id = nil)
      return "#{CHANNEL_PREFIX_NAME}#{id}" if id
      "#{CHANNEL_PREFIX_NAME}#{params[:id]}"
    end
  end
end
