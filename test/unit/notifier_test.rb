# encoding: utf-8

require File.dirname(__FILE__) + '/../test_helper'
require 'notifier'
require 'mocha'
class NotifierTest < ActionMailer::TestCase
  fixtures :users, :orders
  remote_fixtures

  test "should receive estimate request confirmation" do
    response = Notifier.create_estimate_request_from_user(Order.first)
    assert_equal '[GIIF] Solicitud de cotización enviada', response.subject
  end

  test "should send estimate to provider from some user" do
    response = Notifier.create_estimate_to_provider(Order.first, Provider.first)
    assert_equal '[GIIF] Solicitud de cotización del IFUNAM', response.subject
  end

  test "should send estimate response for provider" do
    response = Notifier.create_estimate_response_from_provider(Order.first, Provider.first)
    assert_equal '[GIIF] Solicitud de cotización respondida', response.subject
  end

  test "should send order request sending from some user" do
    response = Notifier.create_order_request_from_user(Order.first)
    assert_equal '[GIIF] Solicitud de orden de compra enviada', response.subject
  end

  test "Should notify to the user incharge" do
    response = Notifier.create_order_to_userincharge(Order.first, 'fereyji@somewhere.com')
    assert_equal '[GIIF] Solicitud de aprobación de orden de compra', response.subject
   end
 
   test "Should notify to user about order request approved" do
     response = Notifier.create_order_request_approved(Order.first)
     assert_equal '[GIIF] Aprobación de solicitud interna de compra', response.subject
   end
 
   test "Should notify to user about oreder request rejected" do
    response = Notifier.create_order_request_rejected(Order.first)
    assert_equal '[GIIF] Rechazo de solicitud interna de compra', response.subject
   end
end
