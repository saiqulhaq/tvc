module VisitorsCounter
  module Trackers
    class TopicTracker
      attr_accessor :topic_id

      def initialize(topic_id)
        self.topic_id = topic_id
      end

      def topic_id=(id)
        @topic_id = id.to_i
      end

      def valid?
        topic_id.positive?
      end

      def new_visit(new_visitors = 1)
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
end
