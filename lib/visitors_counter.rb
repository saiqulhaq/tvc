module VisitorsCounter
  # Used as engine name
  def self.plugin_name
    'visitors_counter'
  end

  def self.lib_base_path
    File.expand_path('./../../lib/visitors_counter', __FILE__)
  end

  # autoload :Engine,      lib_base_path + '/engine'

  # autoload :ClientTrackersController,   lib_base_path + '/client_trackers_controller'
  # autoload :Routes,      lib_base_path + '/routes'

  # Routes.setup

  def self.version
    0.2
  end
end
