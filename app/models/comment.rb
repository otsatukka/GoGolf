class Comment < ActiveRecord::Base
  acts_as_voteable
  
  belongs_to :commentable, :polymorphic => true
  has_many :replies, :dependent => :destroy
  belongs_to :user
  
  validates_presence_of :title, :body
  validates_length_of           :body, :in => 2..2000
  
  
end
