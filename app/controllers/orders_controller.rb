class OrdersController < ApplicationController
  authorize_resource
  before_filter :tabify
  
  def tabify
    @active_tab = "godeal"
  end
  
  def index
    if params[:user_id]
      @orders = Order.where(:user_id => params[:user_id])
    else
      if current_user.role?(:super_admin)
        @orders = Order.all
      else
        access_denied
      end
    end
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def create
    @order = Order.new(params[:order])
    @order.user = current_user
    @order.status = 'created'
    @order.deal = Deal.find(params[:deal_id])
    if @order.quantity > @order.deal.quantity
      @order.errors[:base] << "Määrä on suurempi kuin mitä on jäljellä."
    end

    respond_to do |format|
      if @order.errors[:base].empty? and @order.save
        format.html { redirect_to(user_order_path(current_user, @order), :notice => 'Tilaus luotu.') }
      else
        format.html { redirect_to(deals_path, :notice => 'Tilasitko enemmän tuotteita mitä on jäljellä?') }
      end
    end
  end
  
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(user_orders_path(current_user)) }
    end
  end
end