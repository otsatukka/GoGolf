class AddRealnameToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :realname
    end
  end

  def self.down
    remove_column :users, :realname
  end
end
