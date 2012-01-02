class CreateMetricsTable < ActiveRecord::Migration
  def self.up
    create_table :metrics do |t|
      t.text :label
      t.text :value
      t.integer :timestamp
    end   
  end

  def self.down
    drop_table :metrics
  end
end
