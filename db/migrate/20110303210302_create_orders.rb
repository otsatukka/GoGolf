class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :quantity
      t.string :status
      t.string :code
      t.references :user
      t.references :deal
      
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
