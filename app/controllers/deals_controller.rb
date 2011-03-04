class DealsController < ApplicationController
  before_filter :tabify
  load_and_authorize_resource
  def tabify
    @active_tab = "godeal"
  end
  
  # GET /deals
  # GET /deals.xml
  def index
    @deals = Deal.all
    @order = Order.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deals }
    end
  end

  # GET /deals/1
  # GET /deals/1.xml
  def show
    @deal = Deal.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /deals/new
  # GET /deals/new.xml
  def new
    @deal = Deal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deal }
    end
  end

  # GET /deals/1/edit
  def edit
    @deal = Deal.find(params[:id])
  end

  # POST /deals
  # POST /deals.xml
  def create
    @deal = Deal.new(params[:deal])

    respond_to do |format|
      if @deal.save
        format.html { redirect_to(deals_path, :notice => 'Uusi diili luotu.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /deals/1
  # PUT /deals/1.xml
  def update
    @deal = Deal.find(params[:id])

    respond_to do |format|
      if @deal.update_attributes(params[:deal])
        format.html { redirect_to(deals_path, :notice => 'Diili päivitetty.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.xml
  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy

    respond_to do |format|
      format.html { redirect_to(deals_url) }
      format.xml  { head :ok }
    end
  end
end
