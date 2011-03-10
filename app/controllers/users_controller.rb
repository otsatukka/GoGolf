class UsersController < ApplicationController
  before_filter :get_user, :only => [:index,:new,:edit]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  before_filter :set_title
  before_filter :tabify
  
  # IMPORTANT
  skip_before_filter :check_username, :only => [:edit, :sign_out, :update]
  load_and_authorize_resource
  
  def tabify
    @active_tab = "mygolf"
  end
  
  def index
    if params[:group_id] != nil
      display_group_members_page
    else
      @users = User.accessible_by(current_ability, :index).limit(20)
      respond_to do |format|
        format.html
      end
    end
  end
  
  def display_group_members_page 
    @group = Group.find(params[:group_id])
    @users = @group.users
    respond_to do |format|
      format.html { render :template => 'groups/manage_group_users' }
      format.xml  { render :xml => @users.to_xml(:dasherize => false) }
      format.json  { render :json => @users.to_json(:dasherize => false) }
    end
  end
  
  def new
    @active_tab = "mygolf"
    @title = "Rekisteröidy"
    @user.build_spec
    respond_to do |format|  
      format.xml  { render :xml => @user }
      format.html
    end
  end
  
  def show
    @title = "Oma Golf"
    @posts = Post.where(params[:id]).order('created_at DESC').paginate(:per_page => 3, :page => params[:posts_page])
    @links = Link.where(params[:id]).order('created_at DESC').paginate(:per_page => 5, :page => params[:links_page])
    respond_to do |format| 
      format.js
      format.html
    end
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
  
  def edit
    respond_to do |format| 
      format.xml  { render :xml => @user }
      format.html
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
  
  def destroy
    @user.destroy
 
    respond_to do |format|
      format.xml  { head :ok }
      format.html { redirect_to :action => :index }      
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      respond_to do |format|
        flash[:notice] = "Käyttäjätili luotu!"
        format.json { render :json => @user.to_json, :status => 200 }
        format.html { redirect_to :controller => 'site', :action => :index}
      end
    else
      respond_to do |format|
        format.json { render :text => "Could not create user", :status => :unprocessable_entity } # placeholder
        format.html { render :action => :new, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    if params[:user][:password].blank?
      [:password,:password_confirmation,:current_password].collect{|p| params[:user].delete(p) }
    else
      @user.errors[:base] << "The password you entered is incorrect" unless @user.valid_password?(params[:user][:current_password])
    end
 
    respond_to do |format|
      if @user.errors[:base].empty? and @user.update_attributes(params[:user])
        flash[:notice] = "Profiili päivitetty!"
        format.json { render :json => @user.to_json, :status => 200 }
        format.html { render :action => :edit }
      else
        format.json { render :text => "Could not update user", :status => :unprocessable_entity } #placeholder
        format.html { render :action => :edit, :status => :unprocessable_entity }
      end
    end
 
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml, :html)
  end
  
  # Get roles accessible by the current user
  #----------------------------------------------------
  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability,:read)
  end
  
  def before_save(user)
    params[:user][:role_ids] = [3]
  end
  
  # Make the current user object available to views
  #----------------------------------------
  def get_user
    @current_user = current_user
  end
  def set_title
    @title = 'Käyttäjät'
  end
  
end