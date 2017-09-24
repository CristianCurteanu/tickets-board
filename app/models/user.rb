# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :boards, foreign_key: 'admin_id'

  validates :email, :first_name, :last_name, presence: true
  validates :password, presence: true, confirmation: true
end
