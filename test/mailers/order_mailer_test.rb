require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "new_order" do
    # Send the email, then test that it got queued
    email = OrderMailer.new_order(orders(:one)).deliver
    assert !ActionMailer::Base.deliveries.empty?
 
    # Test the body of the sent email contains what we expect it to
    assert_equal ['info@pionira-medical.com'], email.from
    assert_equal ['test@example.org'], email.to
    assert_equal 'Ihr Auftrag bei Pionira-Medical', email.subject
    assert email.body.to_s.include?("Auftragsnummer: #{orders(:one).id}")
    puts email.body.to_s
  end

  test "request_security_key" do
    # Send the email, then test that it got queued
    email = OrderMailer.request_security_key(orders(:one)).deliver
    assert !ActionMailer::Base.deliveries.empty?
 
    # Test the body of the sent email contains what we expect it to
    assert_equal ['info@pionira-medical.com'], email.from
    assert_equal ['test@example.org'], email.to
    assert_equal 'Sicherheitsschlüssel', email.subject
    assert email.body.to_s.include?(orders(:one).security_key)
  end
end