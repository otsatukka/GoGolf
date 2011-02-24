class AddMoreToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.boolean :morning
      t.boolean :private, :default => true
      t.string :game_type
      t.string :course_name
    end
  end

  def self.down
    remove_column :events, :morning
    remove_column :events, :private
    remove_column :events, :game_type
    remove_column :events, :course_name
  end
end
