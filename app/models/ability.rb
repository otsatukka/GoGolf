class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    
    
      # SUPER ADMIN
      
      if user.role? :super_admin
        can :manage, :all
        can :access, :rails_admin
      else
        
        #GUEST
        
        can :read, Post
        can :read, Link
        can :read, Achievement
        can :read, Achievement
        can :read, Autolink
        can :read, Course
        can :read, Attendance
        
        can :create, User
        # can :create, Commen
        # can :update, Comment do |comment|
        #  comment.try(:user) == user || user.role?(:moderator)
      end
      
      # BASIC USER
      
      if user.role? :basic
        
        # ATTENDANCE
        can :read, Attendance
        can :create, Attendance
        can :destroy, Attendance, :attendee_id => user.id
        
        # EVENT
        can :read, Event
        can :create, Event
        can :manage, Event, :user_id => user.id
        
        # POSTS
        can :manage, Post, :user_id => user.id
        can :read, Post
        can :create, Post
        
        # OPENINGS
        can :manage, Opening, :user_id => user.id
        can :read, Opening
        can :create, Opening
        
        # GROUPS
        can :read, Group
        can :manage, Group, :creator_id => user.id
        can :create, Group
        can :create, Membership
        can :destroy, Membership, :user_id => user.id
        can :read, Membership
        
        # USERS
        can [:show, :index], User
        can :manage, User, :id => user.id
        
        # LINKS
        can :create, Link
        can :manage, Link, :user_id => user.id
        can :create, Autolink
        
        # FRIENDS
        can :create, Friendship
        can :manage, Friendship
        
        
      end
      
      #ADMIN
      
      if user.role? :admin
        
        # POSTS
        
        can :create, Post
        can :update, Post do |post|
          post.try(:user) == user
        end
      end
    end
end