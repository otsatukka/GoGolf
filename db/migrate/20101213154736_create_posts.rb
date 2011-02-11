class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string      :title
      t.text        :body
      t.boolean     :published, :default => false
      t.boolean     :editors_pick, :default => false
      
      t.references  :user
      t.references  :category
      
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
