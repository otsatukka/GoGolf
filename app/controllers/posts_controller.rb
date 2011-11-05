class PostsController < ApplicationController
	before_filter :set_title, :tabify
	before_filter :log_impressions, :only=> [:show]

	load_and_authorize_resource
	skip_load_resource :only => [:index, :create]
	def tabify
		@active_tab = "goblogi"
	end

	def log_impressions
		@post = Post.find(params[:id])
		# this assumes you have a current_user method in your authentication system
		if current_user
			if @post.impressions.where(:ip_address => request.remote_ip, :user_id => current_user.id).count == 0
				@post.impressions.create!(:ip_address => request.remote_ip, :user_id => current_user.id)
			end
		else
			if @post.impressions.where(:ip_address => request.remote_ip).count == 0
				@post.impressions.create!(:ip_address => request.remote_ip)
			end
		end
	end

	# GET /posts
	# GET /posts.xml
	def index
		@categories = Category.all
		@categories.sort! { |a,b| a.name <=> b.name }
		#@posts = Post.search(params[:search]).category(params[:category]).order("created_at DESC").paginate(:per_page => 2, :page => params[:page])
		@user = User.find_by_id("1")
		if params[:user_id]
			@user = User.find_by_id(params[:user_id] )

		end
		@posts = Post.where(:user_id => @user.id).leaveoutcategory(4).order('created_at DESC').paginate(:per_page => 2, :page => params[:page])

		if params[:id]
			@mainpost =Post.find(params[:id])
		else
		    @mainpost =@posts.first
		end
		@comments = @mainpost.comments
		@mainpost.comments.build
		#@posts = Post.search(params[:search]).category(params[:category]).order("created_at DESC").paginate(:per_page => 5, :page => params[:page])
		#@nikke = User.find_by_id("1")
		respond_to do |format|
			format.html
			format.js
		end
	end

	# GET /posts/1
	# GET /posts/1.xml
	def show
		@sda=@post.category_id
		@category = Category.find_by_id(@sda)
		@postit = Post.order('created_at DESC').limit(8)

		@categories = Category.all
		@comments = @post.comments
		@post.comments.build
		@voting_and_replies = 0
		respond_to do |format|
			format.html
			format.js
		end
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
