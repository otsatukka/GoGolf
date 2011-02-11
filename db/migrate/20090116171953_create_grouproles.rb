class CreateGrouproles < ActiveRecord::Migration
  def self.up
    create_table :grouproles do |t|
      t.string :rolename
      t.timestamps
    end
  end

  def self.down
    drop_table :grouproles
  end
end
