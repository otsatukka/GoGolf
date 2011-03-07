class AddMulliganToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :mulligan, :boolean
  end

  def self.down
    remove_column :comments, :mulligan
  end
end
