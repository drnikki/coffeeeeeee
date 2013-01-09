class CreateStoreConfigs < ActiveRecord::Migration
  def change
    create_table :store_configs do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
