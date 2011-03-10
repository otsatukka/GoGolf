class RoundsController < ApplicationController
  before_filter :get_user, :get_title, :tabify
  
  def tabify
    @active_tab = "mygolf"
  end
  
  load_and_authorize_resource
  
  def index
    @rounds = @user.rounds
    
    if @user == current_user
      @title = "Omat kierrokset"
    end
    
  end
  
  def show 
    @round = @user.rounds.find(params[:id])
  end
  
  def new
    @round = @user.rounds.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @round }
    end
  end
  
  def edit
    @round = @user.rounds.find(params[:id])
  end
  
  def create
    @round = @user.rounds.build(params[:round])

    respond_to do |format|
      if @round.save
        format.html { redirect_to(user_rounds_path, :notice => 'Round was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @round = @user.rounds.find(params[:id])

    respond_to do |format|
      if @round.update_attributes(params[:round])
        format.html { redirect_to(user_rounds_path, :notice => 'Round was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @round = @user.rounds.find(params[:id])
    @round.destroy

    respond_to do |format|
      format.html { redirect_to(user_rounds_path) }
    end
  end
  
  def get_user
    @user = User.find(params[:user_id])
  end
  
  def get_title
    @title = "Kierrokset"
  end
end
