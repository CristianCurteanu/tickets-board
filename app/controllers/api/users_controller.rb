# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    before_action :authorized?, only: :show

    def show
      render status: :ok,
             json:   current_user.slice(:email, :first_name, :last_name)
    end

    def create
      head :created if User.create!(registration_params.except(:token))
    end

    private

    def registration_params
      permitted = params.permit(:email, :first_name, :last_name, :token)
      permitted.merge!(password: decode_password(permitted[:token]))
    end
  end
end
