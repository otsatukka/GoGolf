class AddHideToDeals < ActiveRecord::Migration
  def self.up
    add_column :deals, :visible, :boolean, :default =>true
  end

  def self.down
    remove_column :deals, :visible
  end
end
