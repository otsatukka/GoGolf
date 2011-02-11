class CreateViewcounters < ActiveRecord::Migration
  def self.up
    create_table :viewcounters do |t|
      t.string      :ip_address
      t.integer     :viewcount, :default => "0"
      
      t.references  :post
      t.references  :link
      t.timestamps
    end
  end

  def self.down
    drop_table :viewcounters
  end
end
