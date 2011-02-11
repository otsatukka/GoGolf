class Group < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships 
  
  belongs_to :creator, :class_name => 'User' # the creator
  
  has_many :permissions
  has_many :admins, :source => :user, :through => :permissions
end
