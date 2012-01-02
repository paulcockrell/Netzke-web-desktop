class CreateNodeTypes < ActiveRecord::Migration
  def self.up
    create_table :node_types do |t|
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :node_types
  end
end
