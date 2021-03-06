class ApplicationController < ActionController::Base
	protect_from_forgery
	before_filter :check_username
	before_filter :top_lists
	def top_lists
		@top5_posts_of_week = Post.order("created_at DESC").find_all_by_id(Impression.top5("Post", (Time.now - 9.day), Time.now))
		@top5_openings_of_week = Opening.order("created_at DESC").find_all_by_id(Impression.top5("Opening", (Time.now - 7.day), Time.now))
		@top5_links = Link.find_all_by_id(Vote.top5("Link", Time.now - 7.day, Time.now))
		@dealssit = Post.category(1)
		@screams = Scream.all_screams
	end

	def check_username
		if user_signed_in?
			if current_user.rpx_connected? && current_user.name == nil
				flash[:error] = "Lisaa pakolliset tiedot!"
				redirect_to edit_user_path(current_user)
			end
		end
	end

	rescue_from CanCan::AccessDenied do |exception|
		flash[:alert] = exception.message
		redirect_to root_url
	end
	AutoHtml.add_filter(:sized_image).with(:width => 80, :height => 80) do |text, options|

		text.gsub(/http:\/\/.+\.(jpg|jpeg|bmp|gif|png)(\?\S+)?/i) do |match|
			width = options[:width]
			height= options[:height]
			%|<a href="#{match}"><img src="#{match}" alt="" width="#{width}" height="#{height}" /></a>|
		end
	end
end
