class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.string :name
      t.decimal :price
      t.text :desc
      t.integer :quantity
      t.boolean :frontpage_pick, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :deals
  end
end
