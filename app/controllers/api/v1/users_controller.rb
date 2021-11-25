module Api
  module V1
    class UsersController < ApplicationController
      def create
        @user = User.new(email: params[:email], password: params[:password])
        if @user.save
          head :created
        else
          render json: @user.errors.messages.to_json, status: :unprocessable_entity
        end
      end
    end
  end
end
