class AttendancesController < ApplicationController
  
  # load_and_authorize_resource
  
  def index
    @event = Event.find(params[:event_id])
    @attendees = @event.attendees
    @attendances = @event.attendances
    @title = "Attendees for #{@event.name}"
  end
  
  def new
    @event = Event.find(params[:event_id])
    @requested_attendees = @event.requested_attendees
    @attendance = @event.attendances.build
  end
  
  def create
    @tests = User.find_all_by_id(params[:attendee_ids])
    @event = Event.find(params[:event_id])
    for attendee in @tests do
      Attendance.request(attendee, @event)
    end
    flash[:notice] = "Event request sent."
    redirect_to event_path(@event)
  end
  
  def accept
    @event = Event.find(params[:event_id])
    @attendee = User.find(params[:user_id])
    if @event.requested_attendees.include?(@attendee)
      Attendance.accept(@attendee, @event)
      flash[:notice] = "Event request from #{@event.name} accepted!"
    else
      flash[:notice] = "No event request from #{@event.name}."
    end
    redirect_to @event
  end
  
  
  # Changes an attendance, typically used to change the status of a user's attendance
  # i.e. to change a maybe to a yes.
  def update

  end
  
  
  # Remove a user from a event
  def destroy
    #user = User.find(params[:user_id])
    #event = Event.find(params[:event_id])
    #attendance = Attendance.find_by_attendee_id_and_event_id(user.id, event.id)
    if params[:id]
      @attendance = Attendance.find(params[:id])
    else
      @attendance = Attendance.find_by_attendee_id_and_event_id(params[:attendee_id], params[:event_id])
    end
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
end
