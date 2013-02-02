class AddFlagToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :flag, :timestamp
  end
end
