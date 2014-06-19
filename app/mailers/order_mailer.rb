class OrderMailer < ActionMailer::Base
  default from: "info@pionira-medical.com"
 
  def new_order(order)
    @order = order
    mail(to: @order.email, subject: 'Ihr Auftrag bei Pionira-Medical wurde angelegt')
  end

  def files_uploaded(order)
    @order = order
    mail(to: "info@pionira-medical.com", subject: "Pionira-Medical Auftrag #{@order.id}: Datenupload durchgeführt")
  end

  def request_security_key(order)
    @order = order
    mail(to: @order.email, subject: 'Sicherheitsschlüssel')
  end
end
