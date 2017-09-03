module VisitorsCounter
  # Used as engine name
  def self.plugin_name
    'visitors_counter'
  end

  def self.lib_base_path
    File.expand_path('./../../lib/visitors_counter', __FILE__)
  end

  autoload :Engine,      lib_base_path + '/engine'

  autoload :GlobalViews, lib_base_path + '/global_views'
  autoload :TopicViews,  lib_base_path + '/topic_views'

  autoload :ClientTrackersController,   lib_base_path + '/client_trackers_controller'
  autoload :Routes,      lib_base_path + '/routes'

  Routes.setup
end