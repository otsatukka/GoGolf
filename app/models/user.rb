class User < ActiveRecord::Base
  has_many :posts
  has_many :links
  has_many :rounds
  has_many :courses, :through => :rounds
  
  def before_rpx_auto_create(rpx_user)
    self.realname = rpx_user[:name][:formatted]
  end
  
  # KAVERIT
  has_many :friendships
  has_many :friends, :through => :friendships, :conditions => "status = 'accepted'", :order => :name
  
  has_many :requested_friends, :through => :friendships, :source => :friend, :conditions => "status = 'requested'", :order => :created_at
  has_many :pending_friends, :through => :friendships, :source => :friend, :conditions => "status = 'pending'", :order => :created_at
  
  has_and_belongs_to_many :roles
  
  has_many :permissions, :dependent => :destroy
  has_many :grouproles, :through => :permissions 
  
  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships
  
  before_create :add_basic_role
  
  # PRIVACY
  ##################################################################
  
  def end_user_name
    if self.privacy_name
      self.realname
    else
      self.name
    end
  end
    
  
  # PAPERCLIP
  ##################################################################
  
  has_attached_file :avatar, 
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" }
                                 
 validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif']
 validates_attachment_size :avatar, :less_than => 1.megabyte
 
 # DEVISE
 ##################################################################

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :confirmable, :activatable , 
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :rpx_connectable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :role_ids, :avatar, :name, :realname,
                  :privacy_name
  validates_presence_of :name, :realname
  
  # ROLE
  ##################################################################
  
  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  def add_basic_role
    self.roles = Role.where(:name => "Basic")
  end
  
  # GROUPS
  ##################################################################
  
  def is_admin
    self.grouproles.each do |role|
      if grouprole.rolename == 'administrator' || grouprole.rolename == 'creator'
        return true
      end
    end
    false
  end
  
  # Return true if the user has the administrator role
  # or if the user has the group_admin role for the passed in group.
  def is_group_admin(group)
    if self == group.creator
      return true
    end
  end
  
  # ACHIEVEMENT
  ##################################################################
  
  has_many :achievements

  def award(achievement)
    achievements << achievement.new
  end

  def awarded?(achievement)
    achievements.count(:conditions => { :type => achievement }) > 0
  end
  
  # EVENT
  ##################################################################
  
  has_many :attendances, :foreign_key =>'attendee_id', :dependent => :destroy
  has_many :events, :through => :attendances, :conditions => "status = 'accepted'"
  
  has_many :requested_events, :through => :attendances, :source => :event, :conditions => "status = 'requested'"
  
  def is_event_admin(event)
    if event.user == current_user
      return true
    end
  end
  
  
#  SCREEN_NAME_MIN_LENGTH = 4
#  SCREEN_NAME_MAX_LENGTH = 20
#  PASSWORD_MIN_LENGTH = 4
#  PASSWORD_MAX_LENGTH = 20
#  EMAIL_MAX_LENGTH = 50
#  SCREEN_NAME_RANGE = SCREEN_NAME_MIN_LENGTH..SCREEN_NAME_MAX_LENGTH 
#  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH

#  validates_uniqueness_of   :screen_name, :email
#  validates_length_of       :screen_name, :within =>  SCREEN_NAME_RANGE
#  validates_length_of       :password,    :within =>  PASSWORD_RANGE
#  validates_length_of       :email,       :maximum => EMAIL_MAX_LENGTH
  
 # validates_format_of       :screen_name,
 #                           :with => /^[A-Z0-9_]*$/i, 
  #                          :message => "must contain only letters, " +
  #                          "numbers, and underscores"
  
 # validates_format_of       :email, 
  #                          :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i, 
   #                         :message => "must be a valid email address"
                            
end
