class AddDefaultClusterGrid < ActiveRecord::Migration
  def self.up
      change_column_default :infrastructures, :grid, 'unspecified'
      change_column_default :infrastructures, :cluster, 'unspecified'
  end

  def self.down
      change_column_default :infrastructures, :cluster, ''
      change_column_default :infrastructures, :grid, ''
  end
end
