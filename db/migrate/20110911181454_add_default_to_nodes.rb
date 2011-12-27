class AddDefaultToNodes < ActiveRecord::Migration
  def self.up
      change_column_default :nodes, :infrastructure_id, 2
  end

  def self.down
  end
end
