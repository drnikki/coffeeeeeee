class AddPersonIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :person_id, :integer
  end
end
