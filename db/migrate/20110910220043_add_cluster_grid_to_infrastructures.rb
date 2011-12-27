class AddClusterGridToInfrastructures < ActiveRecord::Migration
  def self.up
    add_column :infrastructures, :grid, :string
    add_column :infrastructures, :cluster, :string
  end

  def self.down
    remove_column :infrastructures, :cluster
    remove_column :infrastructures, :grid
  end
end
