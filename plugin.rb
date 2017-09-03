# name: Discourse Visitors Counter
# about: Visitors Counter
# version: 0.0.1
# authors: Saiqul Haq

PLUGIN_NAME ||= 'visitors_counter'.freeze

register_asset 'javascripts/discourse/initializers/visitors-counter-controller.js.es6'
# register_asset 'javascripts/discourse/initializers/tvc-router.js.es6'
# register_asset 'javascripts/discourse/templates/connectors/topic-title/counter.hbs'

after_initialize do
  require_relative './lib/visitors_counter'
  Dir[Rails.root.join("plugins/visitors_counter/lib/**/*.rb")].each do |f|
    require(f)
  end

  ::Discourse::Application.routes.append do
    mount ::VisitorsCounter::Engine, at: '/_vcounter'
  end
end

