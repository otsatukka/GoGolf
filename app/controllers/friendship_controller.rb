class FriendshipController < ApplicationController
  before_filter :setup_friends
  skip_before_filter :top_lists
  
  authorize_resource
  
  # Send a friend request. # We'd rather call this "request", but that's not allowed by Rails.
  def create
    Friendship.request(@user, @friend)
    flash[:notice] = "Friend request sent."
    redirect_to @friend
  end
  
  def accept
    if @user.requested_friends.include?(@friend)
      Friendship.accept(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.end_user_name} accepted!"
    else
      flash[:notice] = "No friendship request from #{@friend.end_user_name}."
    end
    
    redirect_to user_url(@friend)
  end
  
  def decline
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.end_user_name} declined"
    else
      flash[:notice] = "No friendship request from #{@friend.end_user_name}."
    end
    redirect_to user_url
  end
  
  def cancel
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship request canceled."
    else
      flash[:notice] = "No request for friendship with #{@friend.end_user_name}"
    end
    redirect_to user_url
  end
  
  def delete
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.end_user_name} deleted!"
      else
      flash[:notice] = "You aren't friends with #{@friend.end_user_name}"
    end
    redirect_to user_url
  end
  
  private
  
  def setup_friends
    @user = current_user
    @friend = User.find(params[:id])
  end
end
