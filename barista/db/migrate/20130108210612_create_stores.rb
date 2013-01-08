class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :variable
      t.text :value

      t.timestamps
    end
  end
end
