class CreateTableless < ActiveRecord::Migration
  def self.up
    create_table :tableless do |t|
    end
  end

  def self.down
    drop_table :tableless
  end
end
