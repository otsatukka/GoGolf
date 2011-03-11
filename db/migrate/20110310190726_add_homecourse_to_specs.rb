class AddHomecourseToSpecs < ActiveRecord::Migration
  def self.up
    add_column :specs, :course_id, :integer
    add_column :specs, :course_name, :string
    add_column :specs, :hcp, :integer
  end

  def self.down
    remove_column :specs, :hcp
    remove_column :specs, :course_name
    remove_column :specs, :course_id
  end
end
