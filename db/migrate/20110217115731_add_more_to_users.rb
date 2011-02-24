class AddMoreToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.boolean :privacy_name, :default => false
      t.boolean :privacy_search, :default => false
    end
  end

  def self.down
    remove_column :users, :privacy_name
    remove_column :users, :privacy_search
  end
end
