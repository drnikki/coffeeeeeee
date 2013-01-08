class Order < ActiveRecord::Base
  attr_accessible :fulfilled, :item, :placed
end
