require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  test "should route to orders sign_in or show" do
    assert_routing '/orders/1', {controller: "orders", action: "show", id: "1"}
    assert_routing '/orders', {controller: "orders", action: "sign_in"}
    assert_routing '/orders/sign_in/1', {controller: "orders", action: "sign_in", id: "1"}
    assert_routing({method: 'post', path: '/orders/authenticate'}, {controller: "orders", action: "authenticate"})
  end

  test "should display sign_in page in success and error cases" do
    get :sign_in, id: orders(:one).id
    assert @response.body.include?(I18n.t('orders.sign_in.welcome'))

    get :sign_in
    assert @response.body.include?(I18n.t('orders.sign_in.welcome'))

    get :sign_in, id: "does_not_exist"
    assert @response.body.include?(I18n.t('orders.sign_in.id_error'))
  end

  test "should redirect to order after successfully signed in" do
    post :authenticate, id: orders(:one).id, security_key: orders(:one).security_key
    assert_redirected_to(controller: :orders, action: :show, id: orders(:one).id)
  end

  test "should display form after failing to sign_in" do
    post :authenticate, id: orders(:one).id, security_key: "a_wrong_key"
    assert_response :success
    assert @response.body.include?(I18n.t('orders.authenticate.security_key_not_valid'))
  end

  test "should display the order" do
    get :show, {id: orders(:one).id}, {order_id: orders(:one).id, order_security_key: orders(:one).security_key}
  end
  
  test "should redirect to sign in page if the params id is not valid" do
    get :show, {id: "wrong_id"}, {order_id: orders(:one).id, order_security_key: orders(:one).security_key}
    assert_redirected_to(controller: :orders, action: :sign_in, :id => "wrong_id")
    # assert_equal flash[:warn], I18n.t('orders.authenticate.only_one_session_allowed')
  end

  test "should redirect to sign in page if the stored order is not valid" do
    get :show, {id: orders(:one).id}, {order_id: orders(:one).id, order_security_key: "a wrong key"}
    assert_redirected_to(controller: :orders, action: :sign_in, :id => orders(:one).id)
    # assert_equal flash[:danger], I18n.t('orders.authenticate.session_not_valid')
    
  end

  test "successfully requesting the security key" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :request_security_key, id: orders(:one).id
    end
    email = ActionMailer::Base.deliveries.last
 
    assert_equal "Sicherheitsschlüssel", email.subject
    assert_equal orders(:one).email, email.to[0]
    assert email.body.include?(orders(:one).security_key)
    assert @response.body.include?(I18n.t('orders.request_security_key.send'))
  end

  test "trying to request the security key with a wrong id" do
    assert_difference 'ActionMailer::Base.deliveries.size', 0 do
      post :request_security_key, id: "wrong_id"
    end
    assert @response.body.include?(I18n.t('orders.request_security_key.failed'))
  end
end
