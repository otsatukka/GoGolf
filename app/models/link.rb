class Link < ActiveRecord::Base
  belongs_to                      :user
  
  has_one                         :autolink, :dependent => :destroy
  accepts_nested_attributes_for   :autolink
  
  validates_presence_of           :title
  validates_presence_of           :body
  
  validates_length_of             :title, :in => 2..200
  validates_length_of             :body, :in => 2..500
  
end
