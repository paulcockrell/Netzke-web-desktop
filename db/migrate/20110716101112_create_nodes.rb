class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.integer :node_rack_id
      t.string :label
      t.integer :operating_system_id
      t.integer :node_type_id
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :nodes
  end
end
