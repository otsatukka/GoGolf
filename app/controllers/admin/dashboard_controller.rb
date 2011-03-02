class Admin::DashboardController < ApplicationController
  before_filter :auth, :tabify
  
  def tabify
    @active_tab = "admin"
  end
  
  def auth
    authorize! :manage, :all
  end
  
  def index
    @categories = Category.all
  end
  
  def posts
    @posts = Post.search(params[:search]).category(params[:category]).paginate(:per_page => 5, :page => params[:page])
    @categories = Category.all
  end
  
  def users
    @users = User.accessible_by(current_ability, :index).limit(20)
  end
  
  def links
    @links = Link.all
  end
  
end