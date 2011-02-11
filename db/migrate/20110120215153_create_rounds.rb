class CreateRounds < ActiveRecord::Migration
  def self.up
    create_table :rounds do |t|
      t.integer :strokes
      t.references :user
      t.references :course

      t.timestamps
    end
  end

  def self.down
    drop_table :rounds
  end
end
