class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def redirect_if_not_authenticated
    if !session_has_order_info
      redirect_to({ action: :sign_in, id: params[:id] })
    elsif !params_matches_with_session_order_info
      redirect_to({ action: :sign_in, id: params[:id] }, { warn: t('orders.authenticate.only_one_session_allowed') })
    elsif !Order.exists?(id: session[:order_id], security_key: session[:order_security_key])
      session[:order_id] = nil
      session[:order_security_key] = nil
      redirect_to({ action: :sign_in}, { danger: t('orders.authenticate.session_not_valid') })
    end
  end

  def redirect_if_authenticated
    if session_has_order_info && params_matches_with_session_order_info
      redirect_to({ action: :show, id: params[:id] })
    end
  end
end
