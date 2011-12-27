class CreateDataCenters < ActiveRecord::Migration
  def self.up
    create_table :data_centers do |t|
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :data_centers
  end
end
