module FriendshipHelper
  def friendship_status(user, friend)
    friendship = Friendship.find_by_user_id_and_friend_id(user, friend)
    return "#{friend.end_user_name} ei ole kaverisi (viela)." if friendship.nil?
    case friendship.status
    when 'requested'
      "#{friend.end_user_name} haluaisi olla kaverisi."
    when 'pending'
      "Olet lahettanyt kaveripyynnon #{friend.end_user_name}:lle."
    when 'accepted'
      "#{friend.end_user_name} on kaverisi."
    end
  end
end
