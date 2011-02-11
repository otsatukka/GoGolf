class AddCreatorIdToGroups < ActiveRecord::Migration
  def self.up
    change_table :groups do |t|
      t.integer :creator_id
    end
  end

  def self.down
    remove_column :groups, :creator_id
  end
end
