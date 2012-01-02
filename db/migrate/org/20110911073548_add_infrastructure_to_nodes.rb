class AddInfrastructureToNodes < ActiveRecord::Migration
  def self.up
    add_column :nodes, :infrastructure_id, :integer
  end

  def self.down
    remove_column :nodes, :infrastructure_id
  end
end
