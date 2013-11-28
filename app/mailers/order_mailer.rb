class OrderMailer < ActionMailer::Base
  default from: "info@pionira-medical.com"
 
  def new_order(order)
    @order = order
    mail(to: @order.email, subject: 'New Order')
  end

  def request_security_key(order)
    @order = order
    mail(to: @order.email, subject: 'Sicherheitsschlüssel')
  end
end
