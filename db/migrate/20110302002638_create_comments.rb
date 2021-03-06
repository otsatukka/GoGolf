class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string      :title
      t.text        :body
      t.integer     :commentable_id
      t.string      :commentable_type
      t.boolean     :positive

      t.references  :user
      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end

  def self.down
    drop_table :comments
  end
end
