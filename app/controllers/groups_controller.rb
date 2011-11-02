class GroupsController < ApplicationController
  # must be a group admin to edit or update a group
  before_filter :check_group_auth, :only => [:edit, :update]
  before_filter :tabify
  
  # must be an admin to create new groups
  before_filter :check_admin_auth, :only => [:new, :create]
  
  load_and_authorize_resource
  def tabify
    @active_tab = "mygolf"
  end
  
  def check_admin_auth
    if !current_user.role.super_admin?
      redirect_to users_url
    end
  end
  
  
  def check_group_auth
    if !current_user.is_group_admin(Group.find(params[:id]))
      redirect_to users_url
    end
  end
  
  def index
    @section = 'GROUPS'   
    if params[:user_id]
      @user = User.find(params[:user_id])
      @groups = @user.groups
    else 
      @groups = Group.find(:all)
    end
  end


  def show
    @group = Group.find(params[:id])
  end


  def new
    @group = Group.new
  end


  def edit
    @group = Group.find(params[:id])
  end


  def create
    # sleep 4  # required for photo upload
    @group = Group.new(params[:group])
    @group.creator = current_user;
    respond_to do |format|
      if @group.save             
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to(@group) }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @group = Group.find(params[:id])
    respond_to do |format|
      if @group.update_attributes(params[:group])       
   
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to(@group)}
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    respond_to do |format|
      format.html { redirect_to(groups_url) }
    end
  end
end
