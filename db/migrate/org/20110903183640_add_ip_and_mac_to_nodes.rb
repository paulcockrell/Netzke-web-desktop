class AddIpAndMacToNodes < ActiveRecord::Migration
  def self.up
    add_column :nodes, :ip_address,  :string
    add_column :nodes, :mac_address, :string
  end

  def self.down
    remove_column :nodes, :ip_address
    remove_column :nodes, :mac_address
  end
end
