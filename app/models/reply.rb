class Reply < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user
  validates_presence_of :body
  validates_length_of           :body, :in => 2..400
end
