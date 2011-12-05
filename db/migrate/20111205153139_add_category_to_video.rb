class AddCategoryToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :category, :string
  end

  def self.down
    remove_column :videos, :category
  end
end
