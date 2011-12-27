class CreateInfrastructures < ActiveRecord::Migration
  def self.up
    create_table :infrastructures do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :infrastructures
  end
end
