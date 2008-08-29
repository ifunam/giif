require File.dirname(__FILE__) + '/../test_helper'
require 'notifier'

class NotifierTest < ActionMailer::TestCase
  tests Notifier
  def setup
    @order = Order.new(:user_id => 2, :order_status_id => 1, :user_incharge_id => 1, :date => '2008-08-10', :created_at => '2008-08-10')
    @order.id = 45
  end

  def test_order_request
    response = Notifier.create_order_request(@order)
    assert_equal("Pragmatic Store Order Confirmation" , response.subject)
    assert_equal("dave@pragprog.com" , response.to[0])
    assert_match(/Dear Dave Thomas/, response.body)
  end
end
