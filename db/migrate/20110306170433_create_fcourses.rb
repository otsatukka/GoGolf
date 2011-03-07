class CreateFcourses < ActiveRecord::Migration
  def self.up
    create_table :fcourses do |t|
      t.integer :course_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :fcourses
  end
end
