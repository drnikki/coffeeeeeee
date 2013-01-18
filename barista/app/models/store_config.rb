class StoreConfig < ActiveRecord::Base
  attr_accessible :name, :value

  self.primary_key = 'name'
end
