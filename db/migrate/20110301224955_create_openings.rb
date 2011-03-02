class CreateOpenings < ActiveRecord::Migration
  def self.up
    create_table :openings do |t|
      t.string      :title
      t.text        :body
      t.boolean     :published,       :default => false
      t.boolean     :editors_pick,    :default => false
      t.boolean     :weektopic,       :default => false
      t.integer     :use_uploaded_image
      t.string      :photo
      
      t.references  :user
      t.references  :category
      t.references  :imagebank
      
      t.timestamps
    end
  end

  def self.down
    drop_table :openings
  end
end