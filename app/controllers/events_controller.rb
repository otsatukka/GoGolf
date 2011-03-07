class EventsController < ApplicationController
  before_filter :get_user, :tabify, :get_title
  autocomplete :course, :name, :full => true
  
  load_and_authorize_resource
  
  def get_user
    @current_user = current_user
  end
  def get_title
    @title = "Pelit"
  end
  def tabify
    @active_tab = "mygolf"
  end
  
  # GET /events
  # GET /events.xml
  def index
    @events = Event.where("start_time > ?", Time.now)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end
  
  def search
    @title = "Hae peliseuraa"
    @open_events = Event.where(:private => false)
  end
  
  # Includes past events
  def full_index
    @past_events = true
    @events = Event.find(:all, :order=>'start_time ASC')
    respond_to do |format|
      format.html { render :template => 'events/index' }
      format.xml  { render :xml => @events }
      format.json { render :json => @events.to_json }
    end
  end
  
  def game_company
    @event = Event.new
    respond_to do |format|
      format.html { render :template => 'events/game_company' }
      format.js { render :json => @events.to_json }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])
    if @event.private
      if @event.requested_attendees.include?(current_user)
        @attendance_id = @event.attendances.find_by_attendee_id(current_user.id).id
      end
    end
      
    @title = "Pelit >> " + @event.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    if params[:private] == 'true'
      @event.private = true
      @private = true
    else
      @event.private = false
      @private = false
    end
    
    @event.attendances.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    @tests = User.find_all_by_id(params[:attendee_ids])
    for attendee in @tests do
      Attendance.request(attendee, @event)
    end
    @event.user = current_user
    respond_to do |format|
      if @event.save
        format.html { redirect_to event_path(@event), :notice => 'Event was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
