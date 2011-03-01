class CreateImagebanks < ActiveRecord::Migration
  def self.up
    create_table :imagebanks do |t|
      t.string :image
      t.timestamps
    end
  end

  def self.down
    drop_table :imagebanks
  end
end
