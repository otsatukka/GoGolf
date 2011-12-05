class AddSubcategoryToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :subcategory, :string
  end

  def self.down
    remove_column :videos, :subcategory
  end
end
