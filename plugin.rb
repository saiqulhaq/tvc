# name: Topic Viewers Counter
# about: A super simple plugin to demonstrate how plugins work
# version: 0.0.1
# authors: M Saiqul Haq

# this plugin should use message_bus gem version greater than 2.0.0.beta.5
# gem 'message_bus', '> 2.0.0.beta.5'

PLUGIN_NAME ||= 'topic_viewers_counter'.freeze
CHANNEL_PREFIX_NAME = 'topic_viewers_'

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
    redis_key = "#{CHANNEL_PREFIX_NAME}#{msg.data}"
    MessageBus.publish("/topic-viewers-#{msg.data}", { viewers: $redis.hlen(redis_key) })
  end

  require_dependency 'application_controller'

  class DiscourseTvc::TopicViewersController < ::ApplicationController
    def on_open
      redis_channel = "topic_viewers_#{params[:id]}"
      $redis.hset(redis_channel, session.id.to_s.first(16), Time.zone.now.to_i)
      MessageBus.publish('/view-topic', params[:id])
      render json: { subscribed: true }
    end

    # TODO manage connected user data
    # def on_connected
    # end

    def on_close
      redis_channel = "topic_viewers_#{params[:id]}"
      $redis.hdel(redis_channel, session.id.to_s.first(16))
      MessageBus.publish('/view-topic', params[:id])
      render json: { unsubscribed: true }
    end
  end

  DiscourseTvc::Engine.routes.draw do
    get '/track/:id/incr' => 'topic_viewers#on_open'
    get '/track/:id/decr' => 'topic_viewers#on_close'
  end

  ::Discourse::Application.routes.append do
    mount ::DiscourseTvc::Engine, at: '/tvc'
  end

end

