class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.references :user
      t.string :desc
      t.references :course
      t.datetime :start_time

      t.timestamps
    end
    change_table :rounds do |t|
      t.datetime :start_time
    end
  end

  def self.down
    drop_table :events
    remove_column :rounds, :start_time
  end
end
