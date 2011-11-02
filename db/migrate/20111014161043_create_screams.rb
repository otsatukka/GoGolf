class CreateScreams < ActiveRecord::Migration
  def self.up
    create_table :screams do |t|
      t.string :name
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :screams
  end
end
