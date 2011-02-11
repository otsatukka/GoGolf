class AddAnnouncementsToGroups < ActiveRecord::Migration
  def self.up
    change_table :groups do |t|
      t.text :announcements
    end
  end

  def self.down
    remove_column :groups, :announcements
  end
end
