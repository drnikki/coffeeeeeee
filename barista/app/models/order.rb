class Order < ActiveRecord::Base
  attr_accessible :fulfilled, :item, :placed, :person_id, :special_instructions, :milk, :priority

  # so that on creation, it hasn't be fulfilled yet and it was ordered now
  before_create :set_order_times

  def set_order_times
    self.fulfilled = nil
    self.placed = Time.now
  end

 # business rules?  oh... here, huh?
  def get_queue_total
    # the QUEUE is only for items created today     @orders = Order.where('fulfilled IS NULL AND created_at > ?', Time.zone.now.beginning_of_day)
    Order.where('fulfilled IS NULL AND created_at > ?', Time.zone.now.beginning_of_day).count
  end

  def get_queue_place(order)
    # must take priority into account.
    Order.where('fulfilled IS NULL AND placed <= ? AND created_at > ?', order.placed, Time.zone.now.beginning_of_day).count 
  end

  def in_queue
    if self.fulfilled.nil? and self.created_at > Time.zone.now.beginning_of_day
      true
    else
      false
    end
  end

  # on the model object itself.
  def self.get_queue_orders
    Order.where('fulfilled IS NULL AND created_at > ?', Time.zone.now.beginning_of_day).order("priority DESC, created_at ASC")
  end

end
