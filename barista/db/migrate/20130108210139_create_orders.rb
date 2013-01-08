class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :item
      t.datetime :placed
      t.datetime :fulfilled

      t.timestamps
    end
  end
end
