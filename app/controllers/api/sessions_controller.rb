# frozen_string_literal: true

module Api
  class SessionsController < ApplicationController
    def create
      auth = AuthenticationService.call(credentials)
      if auth && auth.success?
        SessionToken.create!(token:      auth.result,
                             expires_at: 30.minutes.from_now)
        render json: { token: auth.result }
      else
        error! 401, error: 'Authentication failed, check you credentials'
      end
    end

    def destroy
      SessionToken.find_by(token: request.headers['Authorization']).logout
    end

    private

    def credentials
      login_params = params.permit(:email, :token)
      {
        email:    login_params[:email],
        password: JWT.decode(params[:token], client_key)[0]['data']
      }
    end
  end
end
