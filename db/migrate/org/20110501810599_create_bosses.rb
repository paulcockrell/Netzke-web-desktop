class CreateBosses < ActiveRecord::Migration
  def self.up
    create_table :bosses do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :telephone
      t.string :mobile
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :post_code

      t.timestamps
    end
  end

  def self.down
    drop_table :bosses
  end
end
