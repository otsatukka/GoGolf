class OrderMailer < ActionMailer::Base
  default :from => "gogolf@gogolf.fi"
  
  def purchase_order(order)
    @order = order
    @user = order.user
    @url  = "http://gogolf.fi"
    mail(:to => order.user.email,
         :subject => "Tilausvahvistus ##{order.id} GoGolf verkkokaupan tuotteesta")
  end
end
