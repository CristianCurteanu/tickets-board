# frozen_string_literal: true

class Board < ApplicationRecord
  validates :name, :description, presence: true

  after_initialize :default_background

  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'

  has_many :columns

  def add_user(user)
    user_ids << user.id
    save!
  end

  def users
    User.where(id: user_ids)
  end

  def remove_user(user)
    user_ids.delete(user.id)
    save!
  end

  private

  def default_background
    self.background = '#eee'
  end
end
