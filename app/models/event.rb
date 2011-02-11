class Event < ActiveRecord::Base
  
  has_many :attendances, :dependent => :destroy
  has_many :attendees, :through => :attendances, :conditions => "status = 'accepted'"
  
  has_many :requested_attendees, :through => :attendances, :source => :attendee, :conditions => "status = 'requested'"
  
  has_one :course
  
  belongs_to  :user  # the creator
  
  validates_presence_of :start_time, :name
  
  # after_create :log_activity
  
  after_destroy :cleanup
  
  
  @@cached_events = nil
  
  def self.cached_events
    @@cached_events ||= Event.find(:all, :select=>"id, name, start_time, end_time, location", :conditions=>'start_time>now()', :order=>'start_time ASC', :limit=>6)
  end
  
  def self.reset_cache
    @@cached_events = nil
  end
  
  
  def cleanup
    Event.reset_cache
  end
  
  
  def log_activity
    Activity.create!(:item => self, :user => self.user)
    Event.reset_cache
  end
  
  
end
