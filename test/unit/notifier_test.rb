# encoding: utf-8

require File.dirname(__FILE__) + '/../test_helper'
require 'notifier'
require 'mocha'
class NotifierTest < ActionMailer::TestCase
  fixtures :users, :orders
  remote_fixtures

  test "should test order request sending from some user" do
    response = Notifier.create_order_request_from_user(Order.first)
    assert_equal '[GIIF] Solicitud de orden de compra enviada', response.subject
    assert_equal 'alex@somewhere.com', response.to.first
  end
 
   test "Should notify to the user incharge" do
     response = Notifier.create_order_to_userincharge(Order.first, 'fereyji@somewhere.com')
     assert_equal '[GIIF] Solicitud de aprobación de orden de compra', response.subject
     assert_equal 'fereyji@somewhere.com', response.to.first
   end
 
   test "Should notify to about accepted request" do
     response = Notifier.create_request_approved(Order.first)
     assert_equal '[GIIF] Aprobación de solicitud interna de compra', response.subject
     assert_equal 'alex@somewhere.com', response.to.first
   end
 
   test "Should notify to about rejected request" do
    response = Notifier.create_order_request_rejected(Order.first)
    assert_equal '[GIIF] Rechazo de solicitud interna de compra', response.subject
    assert_equal 'alex@somewhere.com', response.to.first
   end
end
