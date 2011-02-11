class AttendancesController < ApplicationController
  
  # load_and_authorize_resource
  autocomplete :user, :email, :full => true
  
  def index
    @event = Event.find(params[:event_id])
    @attendees = @event.attendees
    @requested_attendees = @event.requested_attendees
    @title = "Attendees for #{@event.name}"
  end
  
  
  #def create
   # event_id = params[:event_id]
    #user = User.find(params[:user_id])
    #@attendance = Attendance.create({:event_id=>params[:event_id], 
     #                                :attendee_id=>user.id})
    #if @attendance.save
     # redirect_to event_path(event_id)
    #else
     # redirect_to event_path(event_id)
    #end
 # end
  def new
    @event = Event.find(params[:event_id])
    @attendance = @event.attendances.build
  end
  
  def create
    @tests = User.find_all_by_id(params[:attendee_ids])
    @event = Event.find(params[:event_id])
    for attendee in @tests do
      Attendance.request(attendee, @event)
    end
    flash[:notice] = "Friend request sent."
    redirect_to event_path(@event)
  end
  
  def accept
    if @event.requested_attendees.include?(@attendee)
      Attendance.accept(@attendee, @event)
      flash[:notice] = "Event request from #{@event.name} accepted!"
    else
      flash[:notice] = "No event request from #{@event.name}."
    end
    redirect_to events_url(@event)
  end
  
  
  # Changes an attendance, typically used to change the status of a user's attendance
  # i.e. to change a maybe to a yes.
  def update

  end
  
  
  # Remove a user from a event
  def destroy
    user = User.find(params[:user_id])
    event = Event.find(params[:event_id])
    attendance = Attendance.find_by_attendee_id_and_event_id(user.id, event.id)
    attendance.destroy
    respond_to do |format|
      format.html { redirect_to event_path(event.id) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
end
