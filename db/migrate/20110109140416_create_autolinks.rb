class CreateAutolinks < ActiveRecord::Migration
  def self.up
    create_table :autolinks do |t|
      t.string      :linkurl
      t.references  :link
      
      t.timestamps
    end
  end

  def self.down
    drop_table :autolinks
  end
end
