# frozen_string_literal: true

class Ticket < ApplicationRecord
  include OrderingHelper

  has_many :comments
  has_many :checkpoints
  belongs_to :column

  validates :title, :description, presence: true

  after_initialize :default_order_number, if: -> { order_number.nil? }

  private

  def last_order_number
    return 0 unless column
    column.tickets.order(order_number: :desc).first.try(:order_number) || 0
  end
end
