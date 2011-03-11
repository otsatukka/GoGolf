class LinksController < ApplicationController
  before_filter :get_link, :only => [ :edit, :update, :destroy, :show ]
  before_filter :set_title, :tabify
  
  authorize_resource
  
  def vote_up
    begin
      current_user.vote_for(@link = Link.find(params[:id]))
      respond_to do |format|
        format.js 
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  def tabify
    @active_tab = "gogolf"
  end
  
  def index
    @top5_links = Link.where(:linktype => "Linkki").find_all_by_id(Vote.top5("Link", Time.now - 7.day, Time.now))
    @top5_videos = Link.where(:linktype => "Video").find_all_by_id(Vote.top5("Link", Time.now - 7.day, Time.now))
    @top5_pictures = Link.where(:linktype => "Kuva").find_all_by_id(Vote.top5("Link", Time.now - 7.day, Time.now))
    
    @links = Link.where(:linktype => "Linkki").order("created_at DESC").limit(3)
    @videos = Link.where(:linktype => "Video").order("created_at DESC").limit(3)
    @pictures = Link.where(:linktype => "Kuva").order("created_at DESC").limit(3)
  end
  
  def links
    @links = Link.where(:linktype => "Linkki").order("created_at DESC").paginate(:per_page => 15, :page => params[:page])
    end
  
  def videos
    @videos = Link.where(:linktype => "Video").order("created_at DESC").paginate(:per_page => 15, :page => params[:page])
  end
  
  def images
    @pictures = Link.where(:linktype => "Kuva").order("created_at DESC").paginate(:per_page => 15, :page => params[:page])
  end
  
  def show
    @comments = @link.comments
    @link.comments.build
    @post = @link
    @voting_and_replies = 0
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @link = Link.new
    @link.autolink = Autolink.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
      format.json
    end
  end
  
  def edit
  end
  
  def create
    @link = Link.new(params[:link])
    @link.user = current_user

    respond_to do |format|
      if @link.save
        format.html { redirect_to(@link, :notice => 'Link was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to(@link, :notice => 'Link was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @link.destroy

    respond_to do |format|
      format.html { redirect_to(links_url) }
    end
  end
  
  def get_link
    @link = Link.find(params[:id])
  end
  
  def set_title
    @title = 'Viihde'
  end
  
  def preview
    autolink = Autolink.new(params[:linkurl])
    render :text => autolink.linkurl_html
  end
end
