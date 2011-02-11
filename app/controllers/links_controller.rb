class LinksController < ApplicationController
  before_filter :get_link, :only => [ :edit, :update, :destroy ]
  before_filter :set_title
  
  load_and_authorize_resource
  
  # GET /links
  # GET /links.xml
  def index
    @links = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  # GET /links/1
  # GET /links/1.xml
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/new
  # GET /links/new.xml
  def new
    @link = Link.new
    @link.autolink = Autolink.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
      format.json
    end
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.xml
  def create
    @link = Link.new(params[:link])
    @link.user = current_user

    respond_to do |format|
      if @link.save
        format.html { redirect_to(@link, :notice => 'Link was successfully created.') }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to(@link, :notice => 'Link was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    @link.destroy

    respond_to do |format|
      format.html { redirect_to(links_url) }
      format.xml  { head :ok }
    end
  end
  
  def get_link
    @link = Link.find(params[:id])
  end
  
  def set_title
    @title = 'Linkit'
  end
  
  def preview
    autolink = Autolink.new(params[:linkurl])
    render :text => autolink.linkurl_html
  end
end
