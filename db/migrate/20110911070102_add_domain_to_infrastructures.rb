class AddDomainToInfrastructures < ActiveRecord::Migration
  def self.up
    add_column :infrastructures, :domain, :string
  end

  def self.down
    remove_column :infrastructures, :domain
  end
end
