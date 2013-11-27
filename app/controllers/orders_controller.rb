class OrdersController < ApplicationController

  def sign_in
  	@order_id = nil
  	if Order.exists?(params[:id])
  	  @order_id = params[:id]
  	  flash.now[:info] = t('orders.sign_in.welcome')
  	else
  	  flash.now[:danger] = t('error_occured')
  	  @errors = {id: t('orders.sign_in.id_error')}
  	end
  end

  def show
  	@order = Order.find_by(id: session[:order_id], security_key: session[:order_security_key])
  	redirect_to({action: :sign_in, id: session[:order_id]}, {danger: "Session not valid"}) if @order.blank?
  end

  def authenticate
  	if Order.find_by(id: params[:id], security_key: params[:security_key])
  	  session[:order_id] = params[:id]
  	  session[:order_security_key] = params[:security_key]
  	  redirect_to({action: :show}, {success: "Successfully signed in"})
  	else
  	  @order_id = params[:id]
  	  @errors = {security_key: "wrong key"}
      render template: "orders/sign_in"
  	end
  end
end
