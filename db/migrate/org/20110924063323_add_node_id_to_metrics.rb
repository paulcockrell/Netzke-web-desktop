class AddNodeIdToMetrics < ActiveRecord::Migration
  def self.up
      add_column :metrics, :node_id, :integer
  end

  def self.down
      remove_column :metrics, :node_id
  end
end
