class Vote < ActiveRecord::Base

  scope :for_voter, lambda { |*args| where(["voter_id = ? AND voter_type = ?", args.first.id, args.first.class.name]) }
  scope :for_voteable, lambda { |*args| where(["voteable_id = ? AND voteable_type = ?", args.first.id, args.first.class.name]) }
  scope :recent, lambda { |*args| where(["created_at > ?", (args.first || 2.weeks.ago)]) }
  scope :descending, order("created_at DESC")

  belongs_to :voteable, :polymorphic => true
  belongs_to :voter, :polymorphic => true

  attr_accessible :vote, :voter, :voteable

  # Comment out the line below to allow multiple votes per user.
  validates_uniqueness_of :voteable_id, :scope => [:voteable_type, :voter_type, :voter_id]
  def self.top5(type, start_date=nil, end_date=nil)
    res = start_date.blank? ? where(:voteable_type => type).find(:all, :select => "voteable_id, count(voteable_id) as frequency",
                      :limit => 5,
                      :conditions => "voteable_id is not null",
                      :group => "voteable_id",
                      :order => "frequency desc") :
                      where("created_at>=? and created_at<=? and voteable_type=?", start_date, end_date, type).find(:all, :select => "voteable_id, count(voteable_id) as frequency",
                                        :limit => 5,
                                        :conditions => "voteable_id is not null",
                                        :group => "voteable_id",
                                        :order => "frequency desc")
                      res.collect!{|r| r.voteable_id}
                      
                  end
end