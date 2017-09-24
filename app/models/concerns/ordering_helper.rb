module OrderingHelper
  extend ActiveSupport::Concern

  def default_order_number
    self.order_number = last_order_number + 1
  end

  def change_order(other)
    transaction do
      current_order = self.order_number
      self.order_number = other.order_number
      other.order_number = current_order
    end
  end
end