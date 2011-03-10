class CategoriesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end
  
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(@category, :notice => 'Category was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /admin/categories/1
  # PUT /admin/categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(@category, :notice => 'Category was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /admin/categories/1
  # DELETE /admin/categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
    end
  end
end
