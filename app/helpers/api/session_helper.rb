# frozen_string_literal: true

module Api
  module SessionHelper
    def current_user
      authorization ||= AuthorizationService.call(request.headers)
      return authorization.result if authorization.result.present? && !expired?

    end

    def authorized?
      error! 401, error: 'Unauthorized' unless current_user
    end

    def expired?
      SessionToken.expired?(request.headers['Authorization'])
    end

    def client_key
      ENV['PUBLIC_KEY']
    end
  end
end
