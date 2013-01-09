class Order < ActiveRecord::Base
  attr_accessible :fulfilled, :item, :placed, :customer

  # so that on creation, it hasn't be fulfilled yet and it was ordered now
  before_create :set_order_times

  def set_order_times
    self.fulfilled = nil
    self.placed = Time.now
  end

end
