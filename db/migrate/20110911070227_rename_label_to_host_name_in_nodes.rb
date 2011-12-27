class RenameLabelToHostNameInNodes < ActiveRecord::Migration
  def self.up
      rename_column :nodes, :label, :hostname
  end

  def self.down
      rename_column :nodes, :hostname, :label
  end
end
