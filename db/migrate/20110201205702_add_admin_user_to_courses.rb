class AddAdminUserToCourses < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.integer :admin_id
    end
  end

  def self.down
    remove_column :courses, :admin_id
  end
end
