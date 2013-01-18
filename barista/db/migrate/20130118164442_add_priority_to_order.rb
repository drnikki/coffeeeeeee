class AddPriorityToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :priority, :integer
  end
end
