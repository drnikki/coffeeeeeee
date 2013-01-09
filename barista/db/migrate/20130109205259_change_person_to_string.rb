class ChangePersonToString < ActiveRecord::Migration
  def up
    change_table :orders do |t|
      t.change :person_id, :string
    end
  end

  def down
    change_table :orders do |t|
      t.change :person_id, :integer
    end
  end
end
