class Attendance < ActiveRecord::Base
  
  # after_create :log_activity
  
  belongs_to :attendee, :class_name => 'User', :foreign_key =>'attendee_id'
  belongs_to :event
  
  def log_activity
    Attendance.log_activity(self)
  end
  
  class << self
    def log_activity(attendance)
      Activity.create!(:item => attendance, :user => attendance.attendee)
    end
  end
  
  def self.exists?(attendee, event)
    not find_by_attendee_id_and_event_id(attendee, event).nil?
  end
  
  def self.request(attendee, event)
    unless Attendance.exists?(attendee, event)
      transaction do
        create(:attendee => attendee, :event => event, :status => 'requested')
      end
    end
  end
  
  def self.accept(attendee, event)
    transaction do
      accepted_at = Time.now
      request = find_by_attendee_id_and_event_id(attendee, event)
      request.status = 'accepted'
      request.accepted_at = accepted_at
      request.save!
    end
  end
  
  def self.breakup(attendee, event)
    transaction do
      destroy(find_by_attendee_id_and_event_id(attendee, event))
    end
  end
  
end
