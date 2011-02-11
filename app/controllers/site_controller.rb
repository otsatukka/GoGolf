class SiteController < ApplicationController
  
  helper :content
  
  def index
    @title = 'Etusivu'
    @recent_posts = Post.all(:order => 'id DESC', :limit => 3)
    @recent_links = Link.all(:order => 'id DESC', :limit => 3)
  end
  
  def share
  end

  def about
    @title = 'Info'
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def help
    @title = 'Apua'
  end
  
  def show
    
  end
end
