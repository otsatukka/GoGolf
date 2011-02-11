class PostAchievementContributorObserver < ActiveRecord::Observer
  observe :post

  def after_create(post)
    desc = post.title
    PostAchievementContributor.check_conditions_for(post.user, desc)
  end
end