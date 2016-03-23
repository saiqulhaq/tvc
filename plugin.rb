# name: tvc
# about: Topic Visitors Counter
# version: 0.0.1
# authors: M Saiqul Haq

PLUGIN_NAME ||= 'discourse_tvc'.freeze
CHANNEL_PREFIX_NAME = 'tvc_'

register_asset 'javascripts/discourse/initializers/tvc-controller.js.es6'
register_asset 'javascripts/discourse/initializers/tvc-router.js.es6'
register_asset 'javascripts/discourse/templates/connectors/topic-title/counter.hbs'

after_initialize do
  module ::DiscourseTvc
    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace DiscourseTvc
    end
  end

  ::MessageBus.subscribe('/view-topic') do |msg|
    sleep 2
    redis_channel = "#{CHANNEL_PREFIX_NAME}#{msg.data}"
    MessageBus.publish("/topic-viewers-#{msg.data}", { viewers: $redis.hlen(redis_channel) })
  end

  require_dependency 'application_controller'

  class DiscourseTvc::TopicVisitorsController < ::ApplicationController
    def on_open
      $redis.hset(redis_channel, session.id.to_s.first(16), Time.zone.now.to_i)
      MessageBus.publish('/view-topic', params[:id])
      render json: { subscribed: true }
    end

    # TODO manage connected user data
    # def on_connected
    # end

    def on_close
      $redis.hdel(redis_channel, session.id.to_s.first(16))
      MessageBus.publish('/view-topic', params[:id])
      render json: { unsubscribed: true }
    end

    private
    def redis_channel(id = nil)
      return "#{CHANNEL_PREFIX_NAME}#{id}" if id
      "#{CHANNEL_PREFIX_NAME}#{params[:id]}"
    end
  end

  DiscourseTvc::Engine.routes.draw do
    get '/track/:id/incr' => 'topic_visitors#on_open'
    get '/track/:id/decr' => 'topic_visitors#on_close'
  end

  ::Discourse::Application.routes.append do
    mount ::DiscourseTvc::Engine, at: '/tvc'
  end

end

