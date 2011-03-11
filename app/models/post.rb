class Post < ActiveRecord::Base
  
  belongs_to :user
  has_one :category
  belongs_to :imagebank
  
  validates_presence_of         :title
  validates_presence_of         :body
  validates_length_of           :title, :in => 2..200
  validates_length_of           :body, :in => 2..2000
  
  attr_accessible :title, :body, :category_id, :user, :published, :weektopic, :editors_pick, :photo, :imagebank_id,
                  :use_uploaded_image, :remove_photo, :visitor_post
  
  mount_uploader :photo, PhotoUploader
  
  has_many :comments, :as => :commentable, :dependent => :destroy  
  accepts_nested_attributes_for :comments
  
  has_many :impressions, :as => :impressionable, :dependent => :destroy  

  def impression_count(start_date=nil,end_date=Time.now)
    start_date.blank? ? impressions.all.size : impressions.where("created_at>=? and created_at<=?",start_date,end_date).all.size
  end
  
  def unique_impression_count(start_date=nil,end_date=nil)
    start_date.blank? ? impressions.select("DISTINCT(ip_address)").all.size : impressions.where("created_at>=? and created_at<=?",start_date,end_date).select("DISTINCT(ip_address)").all.size
  end
  
  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
  def self.category(category)
    if category
      where('CAST(category_id AS char) LIKE ?', "%#{category}%")
    else
      scoped
    end
  end
end
