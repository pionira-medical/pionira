require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  fixtures :orders
  tests OrderMailer
  test "new_order" do
    # Send the email, then test that it got queued
    email = OrderMailer.new_order(orders(:one)).deliver
    assert !ActionMailer::Base.deliveries.empty?
 
    # Test the body of the sent email contains what we expect it to
    assert_equal ['info@pionira-medical.com'], email.from
    assert_equal ['test@example.org'], email.to
    assert_equal 'New Order', email.subject
    assert email.body.to_s.include?("New order from pionira-medical.com")
  end
end