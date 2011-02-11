class Admin::Category < ActiveRecord::Base
  has_many :posts
end
