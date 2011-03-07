class Course < ActiveRecord::Base
  has_many :rounds
  has_many :users, :through => :rounds
  has_many :events
  belongs_to :admin, :class_name => "User", :foreign_key => "admin_id"
  
  has_many :fcourses
  has_many :members, :through => :fcourses, :class_name => "User", :source => :user
  
end
