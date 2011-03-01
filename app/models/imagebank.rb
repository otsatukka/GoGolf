class Imagebank < ActiveRecord::Base
  has_many :posts
  mount_uploader :image, ImagebankUploader
  validates_presence_of :image
end
