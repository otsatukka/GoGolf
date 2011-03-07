class AddVisitorAuthorToPostsAndOpenings < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.boolean :visitor_post, :default => false
    end
    change_table :openings do |t|
      t.boolean :visitor_post, :default => false
    end
  end

  def self.down
    remove_column :posts, :visitor_post
    remove_column :openings, :visitor_post
  end
end
