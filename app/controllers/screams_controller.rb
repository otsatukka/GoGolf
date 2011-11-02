class ScreamsController < ApplicationController
	def index
		@screams = Scream.all_screams
		respond_to do |format|
			format.html # index.html.erb
			format.rss
		end
	end

	def refresdhable
		@screams = Scream.all_screams
		respond_to do |format|
			format.js
		end
	end

	def create
		@scream = Scream.create!(params[:scream])
		@screams = Scream.all_screams

		flash[:notice] = "Thanks for commenting!"
		respond_to do |format|
			format.html { redirect_to screams_path }
			format.js
		end
	end

	def destroy
		@scream = Scream.find(params[:id])
		@scream.destroy
		respond_to do |format|
			format.html { redirect_to screams_path }
			format.js
		end
	end
end
