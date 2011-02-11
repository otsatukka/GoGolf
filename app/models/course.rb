class Course < ActiveRecord::Base
  has_many :rounds
  has_many :users, :through => :rounds
  has_many :events
  belongs_to :admin, :class_name => "User", :foreign_key => "admin_id"
  
end
