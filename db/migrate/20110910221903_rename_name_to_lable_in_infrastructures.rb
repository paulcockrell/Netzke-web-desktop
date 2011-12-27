class RenameNameToLableInInfrastructures < ActiveRecord::Migration
  def self.up
      rename_column :infrastructures, :name, :label
  end

  def self.down
      rename_column :infrastructures, :label, :name
  end
end
