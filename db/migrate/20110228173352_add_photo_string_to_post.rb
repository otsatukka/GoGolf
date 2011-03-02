class AddPhotoStringToPost < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.integer :use_uploaded_image
    end
  end

  def self.down
    remove_column :posts, :use_uploaded_image
  end
end
