class AddInfrastructureToJobs < ActiveRecord::Migration
  
  def self.up
    add_column :jobs, :infrastructure_id, :integer
  end

  def self.down
    remove_column :jobs, :infrastructure_id
  end

end
