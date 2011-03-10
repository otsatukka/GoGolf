class OrdersController < ApplicationController
  load_and_authorize_resource
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def create
    @order = Order.new(params[:order])
    @order.user = current_user
    @order.status = 'created'
    @order.deal = Deal.find(params[:deal_id])

    respond_to do |format|
      if @order.save
        format.html { redirect_to(@order, :notice => 'Deal was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_path) }
    end
  end
end