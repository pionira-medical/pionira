module OrdersHelper
  def help_text_for_sign_in_field(field)
    if @errors && @errors[field]
      return t(@errors[field])
    else
      return t("orders.sign_in.#{field}_hint")
    end
  end
end
