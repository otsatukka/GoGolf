class AddWeektopicToPost < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.boolean :weektopic, :default => false
    end
  end

  def self.down
    remove_column :posts, :weektopic
  end
end
