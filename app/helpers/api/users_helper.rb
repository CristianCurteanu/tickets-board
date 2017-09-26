# frozen_string_literal: true

module Api
  module UsersHelper
    def decode_password(token)
      JWT.decode(token, ENV['PUBLIC_KEY'])[0]['data']
    end
  end
end
