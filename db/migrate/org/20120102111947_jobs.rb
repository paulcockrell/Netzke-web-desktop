class Jobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :title
      t.boolean :success

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
