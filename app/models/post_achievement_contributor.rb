class PostAchievementContributor < Achievement
  def self.check_conditions_for(user, desc)
    # Check if achievement is already awarded before doing possibly expensive
    # operations to see if the achievement conditions are met.
    #if !user.awarded?(self) and user.posts.size > 20
     # user.award(self)
    #end
  end
end