class Deal < ActiveRecord::Base
  has_many :orders
end
