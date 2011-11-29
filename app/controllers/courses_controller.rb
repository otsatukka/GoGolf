class CoursesController < ApplicationController
  before_filter :tabify, :get_title
  load_and_authorize_resource
  
  def get_title
    @title = "Kentat"
  end
  
  def tabify
    @active_tab = "goguide"
  end
  
  def index
    @courses = Course.all(:order => 'name ASC')
  end
  
  def show
    @course = Course.find(params[:id])
  end
  
  def new
    @course = Course.new
  end
  
  def edit
    @course = Course.find(params[:id])
  end
  
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to(@course, :notice => 'Course was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to(courses_url) }
    end
  end
end
