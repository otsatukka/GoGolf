class Link < ActiveRecord::Base
  acts_as_voteable
  
  belongs_to                      :user
  
  has_one                         :autolink, :dependent => :destroy
  accepts_nested_attributes_for   :autolink
  
  has_many :comments, :as => :commentable, :dependent => :destroy  
  accepts_nested_attributes_for :comments
  
  validates_presence_of           :title
  validates_presence_of           :body
  validates_presence_of           :linktype
  
  
  validates_length_of             :title, :in => 2..200
  validates_length_of             :body, :in => 2..500
end
