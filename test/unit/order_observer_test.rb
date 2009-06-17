require File.dirname(__FILE__) + '/../test_helper'
require 'notifier'

class OrderObserverTest < ActiveSupport::TestCase

  fixtures :users, :order_statuses, :orders, :product_categories, :order_products, 
  :providers, :order_providers, :project_types, :projects, :file_types, :order_files, :unit_types

  remote_fixtures
  
  test "send estimate request email confirmation to user" do
    @order = Order.find(1)
    @order.send_estimate_request
    
    assert_equal 2, @order.order_status_id
    response = Notifier.create_estimate_request_from_user(Order.first)
    assert_equal '[GIIF] Solicitud de cotización enviada', response.subject    
  end

  test "send order request email confirmation to user" do
    @order = Order.find(2)
    @order.sent
    
    assert_equal 4, @order.order_status_id
    response = Notifier.create_order_request_from_user(Order.first)
    assert_equal '[GIIF] Solicitud de orden de compra enviada', response.subject    
  end

  test "send email notification to user about order request rejected" do
    @order = Order.find(6)
    @order.reject
    
    assert_equal 5, @order.order_status_id
    response = Notifier.create_order_request_rejected(@order)
    assert_equal '[GIIF] Rechazo de solicitud interna de compra', response.subject    
  end

  test "send email notification to user about order request approved" do
    @order = Order.find(6)
    @order.approve
    
    assert_equal 7, @order.order_status_id
    response = Notifier.create_order_request_approved(@order)
    assert_equal '[GIIF] Aprobación de solicitud interna de compra', response.subject    
  end
  
end
