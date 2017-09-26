# frozen_string_literal: true

class Column < ApplicationRecord
  include OrderingHelper

  belongs_to :board
  has_many :tickets

  validates :title,
            :description,
            :status_name,
            presence: true

  after_initialize :default_order_number, if: -> { order_number.nil? }

  private

  def last_order_number
    return 0 unless board
    board.columns.order(order_number: :desc).first.try(:order_number) || 0
  end
end
