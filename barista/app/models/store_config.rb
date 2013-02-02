class StoreConfig < ActiveRecord::Base
  attr_accessible :name, :value

  self.primary_key = 'name'

  def calculate_avg_wait_time
    wait_time = Order.select('AVG(strftime("%s", fulfilled) - strftime("%s", placed))').to_json
    #self.select("AVG(started_at)")
    @store_config = StoreConfig.find('avg_wait_time')
    @store_config.value = wait_time
  end


end
