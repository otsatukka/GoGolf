class Order < ActiveRecord::Base
  
  belongs_to :deal
  belongs_to :user
  
  validates_presence_of         :quantity
  
  def total_price
     # convert to array so it doesn't try to do sum on database directly
     deal.price * quantity
   end
   
    def paypal_encrypted(return_url, notify_url)
      values = {
        #:business => 'gogolf_1299182069_biz@gogolf.fi',
        :business => 'gogolf@gogolf.fi',
        :cmd => '_xclick',
        :rm => 0,
        :return => return_url,
        :invoice => id,
        :notify_url => notify_url,
        :amount => deal.price,
        :item_name => deal.name,
        :item_number => deal.id,
        :quantity => quantity,
        #:cert_id => "U9B3Q5XCQJKQN"
        :cert_id => "APPNC5QUHYG9Q" # REAL
      }
      #"https://www.paypal.com/cgi-bin/webscr?" + values.to_query
      encrypt_for_paypal(values)
    end
    
    PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")  
    APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")  
    APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")  
    def encrypt_for_paypal(values)  
        signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)  
        OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")  
    end
end
