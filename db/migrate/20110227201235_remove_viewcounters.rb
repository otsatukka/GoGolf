class RemoveViewcounters < ActiveRecord::Migration
  def self.up
    drop_table :viewcounters
  end

  def self.down
    create_table :viewcounters do |t|
      t.string      :ip_address
      t.integer     :viewcount, :default => "0"
      
      t.references  :post
      t.references  :link
      t.timestamps
    end
  end
end
