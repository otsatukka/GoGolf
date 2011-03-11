class Admin::DashboardController < ApplicationController
  before_filter :tabify
  
  def tabify
    @active_tab = "admin"
  end
  before_filter :verify_admin

  
  def index
    @categories = Category.all
  end
  
  def posts
    @posts = Post.search(params[:search]).category(params[:category]).paginate(:per_page => 10, :page => params[:page])
    @categories = Category.all
  end
  
  def openings
    @openings = Opening.search(params[:search]).category(params[:category]).paginate(:per_page => 10, :page => params[:page])
    @categories = Category.all
  end
  
  def users
    @users = User.accessible_by(current_ability, :index).limit(20)
  end
  
  def links
    @links = Link.all
  end
  
  private
  def verify_admin
    redirect_to root_url unless current_user.role?(:admin) || current_user.role?(:super_admin)
  end
end