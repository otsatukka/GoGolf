class Grouprole < ActiveRecord::Base
  
  has_many :permissions, :dependent => :destroy
  has_many :users, :through => :permissions 
  has_many :memberships
  
  
  @@creator = nil
  
  def self.creator
    @@creator ||= Grouprole.find_by_rolename('creator')
  end
  
  def self.admin
    @@admin ||= Grouprole.find_by_rolename('administrator')
  end
  
  
end
