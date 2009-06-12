# encoding: utf-8

require File.dirname(__FILE__) + '/../test_helper'
class OrderTest < ActiveSupport::TestCase
  fixtures :users, :order_statuses, :orders, :product_categories, :order_products, 
  :providers, :order_providers, :project_types, :projects, :file_types, :order_files, :unit_types
  remote_fixtures

  should_have_many :order_products, :order_providers, :order_files
  should_have_one  :currency_order, :budget, :acquisition

  def setup
    @order = Order.find(2)
    @mock_file = mock('file')
  end

  test "Should return the current status" do
    @order = Order.find(2)
    assert_equal 'Solicitud no enviada', @order.current_status
  end

  test "Should change order_status name" do
    @order = Order.find(2)
    @order.sent
    assert_equal 4, @order.order_status_id
  end

  test "Should approve the order" do 
    @order.order_status_id = 4
    @order.approve
    assert_equal 7, @order.order_status_id
  end


  test "Should rejected the order" do 
    @order.order_status_id = 4
    @order.reject
    assert_equal 5, @order.order_status_id
  end

  test "Should change order_status_id to -solicitud sin cotización-" do 
    @order.order_status_id = 2
    @order.send_estimate_to_orders
    assert_equal 10, @order.order_status_id
  end  

  test "Should change order_status_id to -solicitud no enviada-" do 
    @order.order_status_id = 10
    @order.change_to_unsent_order
    assert_equal 3, @order.order_status_id
  end  

  test "Should add new products" do 
    assert_equal 1, @order.products.size
    @order.products_attributes = {"0" => OrderProduct.valid_hash, "1" => OrderProduct.valid_hash}
    @order.save
    assert_equal 3, @order.products.size
  end

  test "Should update product" do 
    product_hash =  OrderProduct.valid_hash
    @order.products_attributes = { "0"=> product_hash.merge(:id => @order.products.first.id) }
    @order.save
    assert_equal product_hash['description'], @order.products.first.description
  end

  test "Should add new providers" do
    assert_equal 1, @order.providers.size
    @order.providers_attributes = {"0"=> Provider.valid_hash, "1" => Provider.valid_hash}
    @order.save
    assert_equal 3, @order.providers.size
  end

  test "Should update provider" do
    provider_hash =  Provider.valid_hash
    @order.providers_attributes = { "0"=> provider_hash.merge(:id => @order.providers.first.id) }
    @order.save
    assert_equal provider_hash['name'], @order.providers.first.name
  end

  test "Should add new files" do
    @order.update_attributes(:files_attributes => {  "0"  => { :file => @mock_file, :file_type_id => 2 }} )
    @order.save
    assert_equal 2, @order.files.count
  end

  test "Should update existent files" do
    @order.update_attributes(:files_attributes => { "0" =>  { :id => @order.files.first.id, :file => @mock_file, :file_type_id => 2 }})
    @order.save
  end

  test "Should add new project" do
    assert_equal 1, @order.projects.size
    @order.projects_attributes = {"0" => Project.valid_hash }
    @order.save
    assert_equal 2, @order.projects.size
  end

  test "Should update projects" do
    project_hash =  Project.valid_hash
    @order.projects_attributes = { "0" => project_hash.merge(:id => @order.projects.first.id)}
    @order.save
    assert_equal project_hash['name'], @order.projects.first.name
  end

  test "Should not create a new order if it doesn't has valid providers" do 
    order = Order.new(Order.valid_hash.merge(
    :products_attributes =>  { "0" => OrderProduct.valid_hash }, 
    :providers_attributes => { "0" => Provider.invalid_hash }
    ) )
    assert !order.valid?
    assert !order.errors.full_messages.empty?
  end

  test "Should not create a new order if it doesn't has valid products" do 
    order = Order.new(Order.valid_hash.merge(
    :products_attributes =>  { "0" => OrderProduct.invalid_hash }, 
    :providers_attributes => { "0" => Provider.valid_hash } 
    ) )
    assert !order.valid?
    assert !order.errors.full_messages.empty?
  end

  test "Should calculate total_price for existent order" do
    @order = Order.find(2)
    assert_equal 56670.0, @order.total_price
  end
end
