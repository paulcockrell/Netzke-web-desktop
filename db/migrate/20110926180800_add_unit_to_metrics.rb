class AddUnitToMetrics < ActiveRecord::Migration
  def self.up
      add_column :metrics, :unit, :string
  end

  def self.down
      remove_column :metrics, :unit
  end
end
