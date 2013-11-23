class Order < ActiveRecord::Base
  after_create :send_new_order_mail

  private
  def send_new_order_mail
  	OrderMailer.new_order(self).deliver
  end
end
