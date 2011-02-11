class Viewcounter < ActiveRecord::Base
  belongs_to :post
  belongs_to :link
  
  attr_accessible :viewcount
  
end