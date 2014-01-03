module ApplicationHelper
  def anrede(order)
    return "Sehr #{order.gender == 'Herr' ? 'geehrter' : 'geehrte'} #{order.gender} #{order.dr_title} #{order.last_name}"
  end
end
