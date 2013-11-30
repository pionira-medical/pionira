class OrdersController < ApplicationController
  include OrdersHelper
  before_filter :redirect_if_not_authenticated, only: [:show]
  
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
  end

  def authenticate
  	order = Order.find_by(id: params[:id], security_key: params[:security_key])
    if order
  	  session[:order_id] = order.id
  	  session[:order_security_key] = order.security_key
  	  redirect_to({action: :show, id: order.id}, {success: t('orders.authenticate.signed_in')})
  	else
  	  @order_id = params[:id]
  	  @errors = {security_key: t('orders.authenticate.security_key_not_valid')}
      render template: "orders/sign_in"
  	end
  end

  def request_security_key
    order = Order.find_by(id: params[:id])
    if order
      OrderMailer.request_security_key(order).deliver
      @order_id = order.id
      flash.now[:success] = t('orders.request_security_key.send')
    else
      flash.now[:danger] = t('orders.request_security_key.failed')
    end
    render template: "orders/sign_in"
  end

  private
  def redirect_if_not_authenticated
    if session_has_no_order_info
      redirect_to({ action: :sign_in, id: params[:id] })
    elsif params_matches_not_with_session_order_info
      redirect_to({ action: :sign_in, id: params[:id] }, { warn: t('orders.authenticate.only_one_session_allowed') })
    elsif !Order.exists?(id: session[:order_id], security_key: session[:order_security_key])
      redirect_to({ action: :sign_in, id: session[:order_id] }, { danger: t('orders.authenticate.session_not_valid') })
    end
  end
end
