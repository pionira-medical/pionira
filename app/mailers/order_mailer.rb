class OrderMailer < ActionMailer::Base
  default from: "info@pionira-medical.com"
 
  def new_order(order)
    @order = order
    mail(to: @order.email, subject: 'New Order')
  end
end
