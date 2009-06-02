require File.dirname(__FILE__) + '/../test_helper'
class OrderTest < ActiveSupport::TestCase
  fixtures :users, :order_statuses, :orders, :product_categories, :order_products, 
           :providers, :file_types

  should_have_many :order_products, :order_providers, :providers
  should_have_one :order_file, :project, :currency_order, :budget, :acquisition

  def setup
    @estimate = Order.first
    @mock_file = mock('file')
  end
  
  def create
    order_id = Order.last.id + 1 #horrible hack
    assert_equal 2, Order.find(order_id).providers.size
    assert_equal 2, Order.find(order_id).products.size
 end

  def update
    assert_equal "Servidores de alto rendimiento IBM", Order.find(1).products.first.description
    assert_equal "ventas@ibm.com.la", Order.find(1).providers.first.email 
  end
 
  def invalid_update
  #   assert_equal "Macbook air LMF90", Order.find(1).products.first.description
  #   assert_equal "tonermex@gmail.com", Order.find(1).providers.first.email
end
 
end