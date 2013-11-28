class OrdersController < ApplicationController

  def sign_in
  	if params[:id].blank? || Order.exists?(params[:id])
  	  @order_id = params[:id]
  	  flash.now[:info] = t('orders.sign_in.welcome')
  	else
  	  flash.now[:danger] = t('error_occured')
  	  @errors = {id: t('orders.sign_in.id_error')}
  	end
  end

  def show
  	@order = Order.find_by(id: session[:order_id], security_key: session[:order_security_key])
  	redirect_to({action: :sign_in, id: session[:order_id]}, {danger: t('orders.authenticate.session_not_valid')}) if @order.blank?
  end

  def authenticate
  	if Order.find_by(id: params[:id], security_key: params[:security_key])
  	  session[:order_id] = params[:id]
  	  session[:order_security_key] = params[:security_key]
  	  redirect_to({action: :show}, {success: t('orders.authenticate.signed_in')})
  	else
  	  @order_id = params[:id]
  	  @errors = {security_key: t('orders.authenticate.security_key_not_valid')}
      render template: "orders/sign_in"
  	end
  end

  def request_security_key
    @order = Order.find_by(id: params[:id])
    if @order
      OrderMailer.request_security_key(@order).deliver
      @order_id = @order.id
      flash.now[:success] = t('orders.sign_in.request_security_key_send')
    else
      flash.now[:danger] = t('orders.sign_in.request_security_key_failed')
    end
    render template: "orders/sign_in"
  end
end
