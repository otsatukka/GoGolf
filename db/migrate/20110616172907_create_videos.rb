class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :name
      t.string :video_id
      t.string :thumbnail_address
      t.text :content
      t.references  :user
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
