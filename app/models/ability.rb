class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
    
    
      # SUPER ADMIN
      
      if user.role? :super_admin
        can :manage, :all
      else
        
        #GUEST
        
        can :read, Post
        can :read, Link
        can :read, Achievement
        can :read, Group
        can :read, Event
        can :read, Viewcounter
        
        can :create, User
        # can :create, Commen
        # can :update, Comment do |comment|
        #  comment.try(:user) == user || user.role?(:moderator)
      end
      
      # BASIC USER
      
      if user.role? :basic
        
        # POSTS
        can :manage, Post, :user_id => user.id
        can :read, Post
        can :create, Post
        
        # GROUPS
        can :manage, Group do |group|
          group.try(:user_id) == group.creator.id
        end
        can :create, Group
        
        # USERS
        can [:show, :index], User
        can :manage, User, :id => user.id
        
        # LINKS
        can :create, Link
        can :manage, Link
        can :update, Link do |link|
          link.try(:user) == user
        end
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