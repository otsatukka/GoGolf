class AddCategoryToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :linktype, :string
  end

  def self.down
    remove_column :links, :linktype
  end
end
