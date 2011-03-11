class PaymentNotification < ActiveRecord::Base
  belongs_to :order
  serialize :params
  after_create :mark_order_as_purchased
  
  private
  
  def mark_order_as_purchased
    if status == "Completed" && params[:secret] == "fdsakjsdf77fd"
      order.update_attribute(:status, "Maksettu")
      new_quantity = order.deal.quantity - 1
      order.deal.update_attribute(:quantity, new_quantity)
      code = (0...8).map{65.+(rand(25)).chr}.join
      order.code = code
      order.update_attribute(:code, code)
      OrderMailer.purchase_order(order).deliver
    end
  end
  
end
