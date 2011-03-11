class Spec < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  validates_presence_of :gender, :birthday
  validates_numericality_of :hcp, :greater_than => (-10), :less_than_or_equal_to => 54
  validates_length_of           :desc, :in => 0..250
end