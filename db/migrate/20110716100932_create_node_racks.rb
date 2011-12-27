class CreateNodeRacks < ActiveRecord::Migration
  def self.up
    create_table :node_racks do |t|
      t.integer :data_center_id
      t.text :label

      t.timestamps
    end
  end

  def self.down
    drop_table :node_racks
  end
end
