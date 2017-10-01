require_dependency 'application_controller'

module VisitorsCounter
  class ClientTrackersController < ::ApplicationController
    def on_open
      render json: { subscribed: true, sessionId: 12323 }
    end

    # def on_connected
    # end

    def on_close
      render json: { unsubscribed: true, sessionId: session.id }
    end
  end
end
