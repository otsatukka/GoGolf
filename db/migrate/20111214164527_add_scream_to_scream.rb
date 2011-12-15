class AddScreamToScream < ActiveRecord::Migration
  def self.up
    add_column :screams, :message, :string
  end

  def self.down
    remove_column :screams, :message
  end
end
