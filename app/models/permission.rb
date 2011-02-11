class Permission < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :grouprole
  belongs_to :group
  
end
