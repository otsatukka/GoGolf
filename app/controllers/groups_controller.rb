class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.xml
  # must be a group admin to edit or update a group
  before_filter :check_group_auth, :only => [:edit, :update]
  before_filter :tabify
  
  # must be an admin to create new groups
  # before_filter :check_admin_auth, :only => [:new, :create]
  
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
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
      format.json { render :json => @groups.to_json }
    end
  end


  def show
    @group = Group.find(params[:id])
    if @group
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @group }
        format.json { render :json => @group } 
      end
    else
      respond_to do |format|
        format.xml { render :status => :unprocessable_entity } 
        format.json { render :status => :unprocessable_entity } 
      end
    end
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
        # if params[:group_photo] 
          # save group photo
         # @group.profile_photo = ProfilePhoto.create!(:is_profile=>true, :uploaded_data => params[:group_photo]) if params[:group_photo].size != 0 
        #end               
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to(@group) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
        format.json { render :json => @group.to_json, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
        format.json { render :json => @group.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @group = Group.find(params[:id])
    respond_to do |format|
      if @group.update_attributes(params[:group])       
   
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to(@group)}
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
        format.json  { render :json => @group.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
      format.json { head :ok } 
    end
  end
end
