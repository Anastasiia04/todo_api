module Api
  module V1
    class RefreshesController < ApplicationController
      before_action :authorize_refresh_request!

      def create
        session = JWTSessions::Session.new(payload: access_payload)
        render json: session.refresh(found_token)
      end

      private

      def access_payload
        build_access_payload_based_on_refresh(payload)
      end
    end
  end
end
