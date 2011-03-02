class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  has_many :replies, :dependent => :destroy
  belongs_to :user
end
