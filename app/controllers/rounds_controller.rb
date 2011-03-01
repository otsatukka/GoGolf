class RoundsController < ApplicationController
  before_filter :get_user, :get_title, :tabify
  
  def tabify
    @active_tab = "mygolf"
  end
  
  load_and_authorize_resource
  
  # GET /rounds
  # GET /rounds.xml
  def index
    @rounds = @user.rounds
    
    if @user == current_user
      @title = "Omat kierrokset"
    end
    
  end

  # GET /rounds/1
  # GET /rounds/1.xml
  def show 
    @round = @user.rounds.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @round }
    end
  end

  # GET /rounds/new
  # GET /rounds/new.xml
  def new
    @round = @user.rounds.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @round }
    end
  end

  # GET /rounds/1/edit
  def edit
    @round = @user.rounds.find(params[:id])
  end

  # POST /rounds
  # POST /rounds.xml
  def create
    @round = @user.rounds.build(params[:round])

    respond_to do |format|
      if @round.save
        format.html { redirect_to(user_rounds_path, :notice => 'Round was successfully created.') }
        format.xml  { render :xml => @round, :status => :created, :location => @round }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @round.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rounds/1
  # PUT /rounds/1.xml
  def update
    @round = @user.rounds.find(params[:id])

    respond_to do |format|
      if @round.update_attributes(params[:round])
        format.html { redirect_to(user_rounds_path, :notice => 'Round was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @round.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.xml
  def destroy
    @round = @user.rounds.find(params[:id])
    @round.destroy

    respond_to do |format|
      format.html { redirect_to(user_rounds_path) }
      format.xml  { head :ok }
    end
  end
  
  def get_user
    @user = User.find(params[:user_id])
  end
  
  def get_title
    @title = "Kierrokset"
  end
end
