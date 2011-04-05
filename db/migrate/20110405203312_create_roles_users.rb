class CreateRolesUsers < ActiveRecord::Migration
  def self.up
    if !ActiveRecord::Base.connection.tables.include?(:roles_users)
      create_table :roles_users, :id => false do |t|
        t.integer :role_id
        t.integer :user_id
        t.timestamps
      end
    end
  end
end
