class PostsController < ApplicationController
  before_filter :set_title, :tabify
  
  impressionist :actions => [:show]
  load_and_authorize_resource
  skip_load_resource :only => [:index, :create]
  
  def tabify
    @active_tab = "gogolf"
  end
  
  # GET /posts
  # GET /posts.xml
  def index
    @categories = Admin::Category.all
    
    @posts = Post.search(params[:search]).category(params[:category]).paginate(:per_page => 5, :page => params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    @imagebanks = Imagebank.all
  end

  # GET /posts/1/edit
  def edit
    @imagebanks = Imagebank.all
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    if params[:photo]
      params[:photostring].delete
    end
    @post.user = current_user
    if params[:use_uploaded_image]
      @post.use_uploaded_image = params[:use_uploaded_image]
    end
    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @imagebanks = Imagebank.all
    if params[:use_uploaded_image] == 0 && params[:imagebank_id]
      @post.remove_photo!
      @post.photo = ' '
    end
    if params[:remove_photo]
      params[:use_uploaded_image] = 0
      @post.use_uploaded_image = 0
    end
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
  def set_title
    @title = 'Uutiset'
  end
end
