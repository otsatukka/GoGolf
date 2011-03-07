class SiteController < ApplicationController
  before_filter :tabify
  
  def tabify
    @active_tab = "gogolf"
  end
  
  helper :content
  def index
    @title = 'Tervetuloa!'
    @editors_picks = Post.where(:editors_pick => true).order('created_at DESC')
    @recent_posts = Post.all(:order => 'id DESC', :limit => 3)
    @recent_links = Link.all(:order => 'id DESC', :limit => 3)
    
    @nikke = User.find_by_realname("Pekka Rihtniemi")
    
    @uusin_nikke_avaus = Opening.where(:weektopic => true, :user_id => @nikke.id).order('created_at DESC')
    @uusin_vieras_avaus = Opening.where(:weektopic => true, :visitor_post => true).order('created_at DESC')
  end
  
  def topic
    @title = "Avaukset"
    @nikke = User.find_by_id("1")
    @viikon_aiheet = Post.where(:weektopic => true)
    @uusin_niken_juttu = @viikon_aiheet.find_by_user_id(@nikke.id)
  end
  
  def picks
    @title = "Toimituksen valinta"
    @nikke = User.find_by_id("1")
    @viikon_aiheet = Post.where(:weektopic => true)
    @uusin_niken_juttu = @viikon_aiheet.find_by_user_id(@nikke.id)
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
