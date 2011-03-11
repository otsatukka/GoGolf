class DealsController < ApplicationController
  before_filter :tabify
  load_and_authorize_resource
  def tabify
    @active_tab = "godeal"
  end
  
  def index
    @deals = Deal.where(:visible => true)
    @order = Order.new
  end
  
  def show
    @deal = Deal.find(params[:id])
  end
  
  def new
    @deal = Deal.new
  end
  
  def edit
    @deal = Deal.find(params[:id])
  end
  
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
  
  def destroy
    @deal = Deal.find(params[:id])
    @orders_which_are_not_been_bought = Order.where(:deal_id => :id, :status => "created")
    # DELETING UNUSED RECORDS!
    for order in @orders_which_are_not_been_bought do
      order.destroy!
    end
    @deal.destroy

    respond_to do |format|
      format.html { redirect_to(deals_url) }
    end
  end
end
