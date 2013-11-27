require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  test "should route to orders sign_in or show" do
    assert_routing '/orders/1', {controller: "orders", action: "sign_in", id: "1"}
    assert_routing '/orders/show', {controller: "orders", action: "show"}
    assert_routing({method: 'post', path: '/orders/authenticate'}, {controller: "orders", action: "authenticate"})
  end

  test "should display sign_in page" do
    get :sign_in, id: orders(:one).id 
    assert_response :success
    assert @response.body.include?("Enter Security Key")
  end

  test "should display sign_in error (wrong id)" do
    get :sign_in, id: "does_not_exist"
    assert_response :success
    assert @response.body.include?("Order not found")
  end

  test "should redirect to order after successfully signed in" do
    post :authenticate, id: orders(:one).id, security_key: orders(:one).security_key
    assert_redirected_to(controller: :orders, action: :show)
  end

  test "should display form after failing to sign_in" do
    post :authenticate, id: orders(:one).id, security_key: "a_wrong_key"
    assert_response :success
    assert @response.body.include?("wrong key")
  end

  test "should display the order" do
    get :show, {}, {order_id: orders(:one).id, order_security_key: orders(:one).security_key}
  end

  test "should redirect to sign in page if the stored order is not valid" do
    get :show, {}, {order_id: orders(:one).id, order_security_key: "a wrong key"}
    assert_redirected_to(controller: :orders, action: :sign_in, :id => orders(:one).id)
  end
end