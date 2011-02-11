class Membership < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :group
  belongs_to :grouprole

  # Returns a count of the number of users that are in groups
  def self.user_count
    memberships = Membership.find(:all)
    # now make unique based on user_id
    users = memberships.map do |membership|
      membership.user_id
    end
    users.uniq.size
  end
  
  def self.promote_to_admin(membership)
    membership.grouprole = Grouprole.find_by_rolename('group_admin')
  end
  
end