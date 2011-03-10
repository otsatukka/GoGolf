class Order < ActiveRecord::Base
  
  belongs_to :deal
  belongs_to :user
  
  def total_price
     # convert to array so it doesn't try to do sum on database directly
     deal.price * quantity
   end
   
    def paypal_url(return_url, notify_url)
      values = {
        :business => 'gogolf_1299182069_biz@gogolf.fi',
        #:business => 'gogolf@gogolf.fi',
        :cmd => '_xclick',
        :rm => 0,
        :return => return_url,
        :invoice => id,
        :notify_url => notify_url,
        :amount => deal.price,
        :item_name => deal.name,
        :item_number => deal.id,
        :quantity => quantity
      }
      "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
      #"https://www.paypal.com/cgi-bin/webscr?" + values.to_query
    end
end
