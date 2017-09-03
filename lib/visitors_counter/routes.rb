module VisitorsCounter
  module Routes
    def self.setup
      Engine.routes.draw do
        get '/track/:id/incr' => 'client_trackers#on_open', as: :track_more_user
        get '/track/:id/decr' => 'client_trackers#on_close', as: :track_less_user
      end
    end
  end
end
