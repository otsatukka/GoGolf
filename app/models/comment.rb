class Comment < ActiveRecord::Base
  acts_as_voteable
  belongs_to :commentable, :polymorphic => true
  has_many :replies, :dependent => :destroy
  belongs_to :user
end
