class AddEditableFieldToInfrastructure < ActiveRecord::Migration
  def self.up
    add_column :infrastructures, :editable, :boolean, :default => 't'
  end

  def self.down
    remove_column :infrastructures, :editable
  end
end
