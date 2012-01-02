class AddLabelToNodes < ActiveRecord::Migration
  def self.up
      add_column :nodes, :label, :string, :default => ''
  end

  def self.down
  end
end
