class Post < ActiveRecord::Base
  
  belongs_to :user
  has_one :category
  
  has_one                       :viewcounter, :dependent => :destroy
  accepts_nested_attributes_for :viewcounter, :category
  
  validates_presence_of         :title
  validates_presence_of         :body
  validates_length_of           :title, :in => 2..200
  validates_length_of           :body, :in => 2..2000
  
  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
  def self.category(category)
    if category
      where('category_id LIKE ?', "%#{category}%")
    else
      scoped
    end
  end
  
  def increase_viewcount(post)
    post.viewcounter.viewcount += 1
  end
end
