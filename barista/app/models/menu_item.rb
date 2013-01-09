class MenuItem < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :orders
end
