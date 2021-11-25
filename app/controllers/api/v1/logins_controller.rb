module Api
  module V1
    class LoginsController < ApplicationController
      def create
        user = User.find_by!(email: params[:email])
        if user.authenticate(params[:password])
          payload = { user_id: user.id }
          session = JWTSessions::Session.new(payload: payload)
          render json: session.login
        else
          render json: { errors: 'Invalid user' }, status: :unauthorized
        end
      end
    end
  end
end
# expect(JSON.parse(response.body)).to eq(errors: 'Invalid user')
# expect(JSON.parse(response.status)).to eq(:unauthorized)
