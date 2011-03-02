class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
    end
    drop_table :admin_categories
  end

  def self.down
    drop_table :categories
    create_table :admin_categories do |t|
      t.string :category_name
      t.timestamps
    end
  end
end
