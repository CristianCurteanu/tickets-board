# frozen_string_literal: true

class SessionToken < ApplicationRecord
  def logout
    update!(expires_at: DateTime.now - 1.minute)
  end

  def self.expired?(token)
    DateTime.now > SessionToken.find_by(token: token).expires_at
  rescue NoMethodError
    nil
  end
end
