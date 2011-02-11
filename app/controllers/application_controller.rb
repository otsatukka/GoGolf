class ApplicationController < ActionController::Base
  protect_from_forgery
  
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
