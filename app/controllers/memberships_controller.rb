class MembershipsController < ApplicationController
  before_filter :tabify
  
  load_and_authorize_resource
  skip_load_resource :only => :index
  
  def tabify
    @active_tab = "mygolf"
  end
  
  def index
    if params[:group_id]
      @memberships = Membership.where(:group_id => params[:group_id])
    end
  end
  
  def show
    @membership = Membership.find(params[:id]) 
    if @membership
      respond_to do |format|
        format.xml { render :xml => @membership } 
        format.json { render :json => @membership } 
      end
    else
      respond_to do |format|
        format.xml { render :status => :unprocessable_entity } 
        format.json { render :status => :unprocessable_entity } 
      end
    end
  end
  
  
  def find
    @membership = Membership.find_by_user_id_and_group_id(params[:user_id], params[:group_id])
    if @membership
      respond_to do |format|
        format.html
        format.xml { render :xml => @membership }  
        format.json { render :json => @membership } 
      end
    else
      respond_to do |format|
        format.html
        format.xml { render :xml => '', :status => :unprocessable_entity }  
        format.json { render :json => '', :status => :unprocessable_entity } 
      end
    end
  end
  
  
  # Add a user to a group
  def create
    group_id = params[:group_id]
    user = User.find(params[:user_id])
    if user == Group.find(params[:group_id]).creator
      role = Grouprole.find_by_rolename('group_admin')
    else
      role = Grouprole.find_by_rolename('user')
    end
    @membership = Membership.create({:group_id => params[:group_id], 
                                     :user_id => user.id,
                                     :grouprole_id => role.id})
    if @membership.save
      respond_to do |format|
        format.html { redirect_to group_path(group_id) }
        format.xml { render :xml => @membership, :status => :created } 
        format.json { render :json => @membership, :status => :created } 
      end
    else
      respond_to do |format|
        format.html { redirect_to group_path(group_id) }
        format.xml  { render :xml => @membership.errors, :status => :unprocessable_entity }
        format.json { render :json => @membership.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # Changes a membership, typically used to change the role of a user, i.e.
  # to promote or demote a member from the group admin role.
  def update
    @membership = Membership.find(params[:id])
    respond_to do |format|
      if @membership.update_attributes(params[:membership])               
        format.html { 
          flash[:notice] = 'Membership was successfully updated.'
          redirect_to :back
          }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @membership.errors, :status => :unprocessable_entity }
        format.json  { render :json => @membership.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end
    
  
  # Remove a user from a group
  def destroy
    # @membership = Membership.find_by_user_id_and_group_id(params[:user_id], params[:group_id])
    @membership = Membership.find(params[:id])
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
      format.json { head :ok } 
    end
  end
  
end