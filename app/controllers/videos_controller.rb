require "json"
require "open-uri"

class VideosController < ApplicationController
	before_filter :tabify

	load_and_authorize_resource
	def tabify
		@active_tab = "golftv"
	end

	# GET /videos
	# GET /videos.xml
	def index
		@title = "Golf TV"
		@videos = Video.all(:order => 'created_at DESC').paginate(:per_page => 8, :page => params[:page])
		@mainvideo = Video.search(params[:search]).order("created_at DESC")
	    @comments = @mainvideo.first.comments
		@mainvideo.first.comments.build
	   
		if @mainvideo.first.video_id.split(".").first == "vimeo"
			@videonumber = @mainvideo.first.video_id.split("/").last
			@vimeo = true
	   else
	   	    @videonumber = @mainvideo.first.video_id.split("=").last
	   	    @vimeo = false
	    end
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @videos }
		end
	end
	def schema(json = ActiveSupport::JSON.decode(schema_json))
	  case json
	  when Array; json.map { |element| schema(element) }
	  when Hash; HashWithIndifferentAccess.new(json)
	  else; json
	  end
	end
	# GET /videos/1
	# GET /videos/1.xml
	def show

		@video = Video.find(params[:id])
		@video.comments.build
		
		@comments = @video.comments
		
		if @video.video_id.split(".").first == "vimeo"
			@videonumber = @video.video_id.split("/").last
			@vimeo = true
	   else
	   	    @videonumber = @video.video_id.split("=").last
	   	    @vimeo = false
	    end
		
		@title = @video.name
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @video }
		end
	end

	# GET /videos/new
	# GET /videos/new.xml
	def new
		@video = Video.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @video }
		end
	end

	# GET /videos/1/edit
	def edit
		@video = Video.find(params[:id])
	end

	# POST /videos
	# POST /videos.xml
	def create
		#image = Magick::ImageList.new
		#urlimage = open("http://img.youtube.com/vi/S5BXCaQCa1k/0.jpg")
		#thumb   =  (RAILS_ROOT + "/public/images/nikko.jpg")
		#image.from_blob(urlimage.read)
		#crop = image.crop(3,45,475,270)
		#crop.write(thumb) do self.quality = 60 end
		#json = open("http://vimeo.com/api/v2/video/5367093.json")
        #dec = ActiveSupport::JSON.decode json
        #@thumb = dec['thumbnail_medium']
		@video = Video.new(params[:video])
		@video.user = current_user
		respond_to do |format|
			if @video.save
				format.html { redirect_to(videos_path, :notice => 'Video was successfully created.') }
				format.xml  { render :xml => @video, :status => :created, :location => @video }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
			end
		end
	end

	def cropit(videoid)
		image = Magick::ImageList.new
		urlimage = open("http://img.youtube.com/vi/#{videoid}/0.jpg")
		image.from_blob(urlimage.read)
		crop = image.crop(3,45,475,270)
	end

	# PUT /videos/1
	# PUT /videos/1.xml
	def update
		@video = Video.find(params[:id])

		respond_to do |format|
			if @video.update_attributes(params[:video])
				format.html { redirect_to(@video, :notice => 'Video was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /videos/1
	# DELETE /videos/1.xml
	def destroy
		@video = Video.find(params[:id])
		@video.destroy

		respond_to do |format|
			format.html { redirect_to(videos_url) }
			format.xml  { head :ok }
		end
	end
end
