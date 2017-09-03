module VisitorsCounter
  class Engine < ::Rails::Engine
    engine_name ::VisitorsCounter.plugin_name
    isolate_namespace ::VisitorsCounter
  end
end
