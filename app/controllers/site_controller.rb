class SiteController < ApplicationController
  before_filter :tabify
  
  def tabify
    @active_tab = "gogolf"
  end
  
  helper :content
  def index
    @title = 'Tervetuloa!'
    @editors_picks = Opening.where(:editors_pick => true).order('created_at DESC').limit(3)
    @recent_posts = Post.all(:order => 'created_at DESC', :limit => 3)
    
    @recent_openings = Opening.all(:order => 'created_at DESC', :limit => 3)
    @recent_links = Link.all(:order => 'created_at DESC', :limit => 3)
    
    #@nikke = User.find_by_realname("Nikke Tyry")
    @nikke = User.find_by_realname("Pekka Rihtniemi")
    
    @uusin_nikke_avaus = Opening.where(:weektopic => true, :user_id => @nikke.id).order('created_at DESC')
    @uusin_vieras_avaus = Opening.where(:weektopic => true, :visitor_post => true).order('created_at DESC')
  end
  
  def guide
    @active_tab = "goguide"
  end
  
  def topic
    @title = "Toimituksen valinnat"
    @viikon_uutis_valinnat = Post.where(:editors_pick => true, :created_at => (Time.now - 7.days)..Time.now).order('created_at DESC')
    @viikon_avaus_valinnat = Opening.where(:editors_pick => true, :created_at => (Time.now - 7.days)..Time.now).order('created_at DESC')
    
    @edellis_viikon_uutis_valinnat = Post.where(:editors_pick => true, :created_at => (Time.now - 14.days)..(Time.now - 7.days)).order('created_at DESC')
    @edellis_viikon_avaus_valinnat = Opening.where(:editors_pick => true, :created_at => (Time.now - 14.days)..(Time.now - 7.days)).order('created_at DESC')
    
    @vanhemmat_uutis_valinnat = Post.where(:editors_pick => true).where("created_at < ?", 2.weeks.ago).order('created_at DESC').paginate(:per_page => 3, :page => params[:posts_page])
    @vanhemmat_avaus_valinnat = Opening.where(:editors_pick => true).where("created_at < ?", 2.weeks.ago).order('created_at DESC').paginate(:per_page => 3, :page => params[:openings_page])
    
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
    @title = 'Yhteystiedot'
  end
  def yleiset_ehdot
    @title = 'Yhteystiedot'
  end
  def verkkokaupan_ehdot
    @title = 'Yhteystiedot'
  end
  
  
  def show
    
  end
end
