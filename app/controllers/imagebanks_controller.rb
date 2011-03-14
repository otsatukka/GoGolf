class ImagebanksController < ApplicationController
  before_filter :get_imagebank, :only => [ :edit, :update, :destroy ]
  before_filter :set_title, :verify_admin
  
  load_and_authorize_resource
  def index
    @imagebanks = Imagebank.all
  end
  
  def show
  end

  def new
    @imagebank = Imagebank.new
  end
  
  def edit
  end
  
  def create
    @imagebank = Imagebank.new(params[:imagebank])

    respond_to do |format|
      if @imagebank.save
        format.html { redirect_to(imagebanks_path, :notice => 'Image was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @imagebank.update_attributes(params[:imagebank])
        format.html { redirect_to(@imagebank, :notice => 'Image was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @imagebank.destroy

    respond_to do |format|
      format.html { redirect_to(imagebanks_url) }
    end
  end
  
  def get_imagebank
    @imagebank = Imagebank.find(params[:id])
  end
  
  def set_title
    @title = 'Kuvat'
  end
  
  private
  
  def verify_admin
    redirect_to root_url unless current_user.role?(:admin) || current_user.role?(:super_admin)
  end
end
