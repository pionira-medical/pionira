module OrdersHelper

  def session_has_order_info
    return !session[:order_id].blank? && !session[:order_security_key].blank?
  end

  def params_matches_with_session_order_info
  	return session[:order_id].to_i == params[:id].to_i
  end

  def help_text_for_sign_in_field(field)
    if @errors && @errors[field]
      return t(@errors[field])
    else
      return t("orders.sign_in.#{field}_hint")
    end
  end
end
