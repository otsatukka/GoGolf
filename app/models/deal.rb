class Deal < ActiveRecord::Base
  has_many :orders
  
  mount_uploader :photo, PhotoUploader
  validates_presence_of :quantity, :name, :price, :desc, :dealtype
end
