class OpeningsController < ApplicationController
  before_filter :set_title, :tabify
  before_filter :log_impressions, :only=> [:show]
  
  load_and_authorize_resource
  skip_load_resource :only => [:index, :create]
  
  def tabify
    @active_tab = "gogolf"
  end
  
  def log_impressions
    @opening = Opening.find(params[:id])
    # this assumes you have a current_user method in your authentication system
    if current_user
      if @opening.impressions.where(:ip_address => request.remote_ip, :user_id => current_user.id).count == 0
        @opening.impressions.create!(:ip_address => request.remote_ip, :user_id => current_user.id)
      end
    else
      if @opening.impressions.where(:ip_address => request.remote_ip).count == 0
        @opening.impressions.create!(:ip_address => request.remote_ip)
      end
    end
  end
  
  def index
    @categories = Category.all
    @categories.sort! { |a,b| a.name <=> b.name }
    
    @openings = Opening.search(params[:search]).category(params[:category]).order("created_at DESC").paginate(:per_page => 5, :page => params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
    @comments = @opening.comments
    @opening.comments.build
    @post = @opening
    @voting_and_replies = 1
  end
  
  def new
    @opening = Opening.new
    @imagebanks = Imagebank.all
  end
  
  def edit
    @imagebanks = Imagebank.all
  end
  
  def create
    @opening = Opening.new(params[:opening])
    if params[:photo]
      params[:photostring].delete
    end
    @opening.user = current_user
    if params[:use_uploaded_image]
      @opening.use_uploaded_image = params[:use_uploaded_image]
    end
    respond_to do |format|
      if @opening.save
        format.html { redirect_to(@opening, :notice => 'opening was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @imagebanks = Imagebank.all
    if params[:use_uploaded_image] == 0 && params[:imagebank_id]
      @opening.remove_photo!
      @opening.photo = ' '
    end
    if params[:remove_photo]
      params[:use_uploaded_image] = 0
      @opening.use_uploaded_image = 0
    end
    
    respond_to do |format|
      if @opening.update_attributes(params[:opening])
        format.html { redirect_to(@opening, :notice => 'opening was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @opening.destroy

    respond_to do |format|
      format.html { redirect_to(openings_url) }
    end
  end
  
  def set_title
    @title = 'Avaukset'
  end
end
