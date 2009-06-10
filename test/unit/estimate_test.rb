# encoding: utf-8

require File.dirname(__FILE__) + '/../test_helper'
class OrderTest < ActiveSupport::TestCase
   fixtures :users, :order_statuses, :orders, :product_categories, :order_products, 
            :providers, :file_types

  should_have_many :order_products, :order_providers

  def setup
    @order = Order.find(1)
  end

  test "Should send estimate request to providers" do 
    @order.send_estimate_request
    assert_equal 'Cotizaciones en progreso', @order.current_status
  end

#    @order.products_attributes = {"0" => {:quantity=>1, :product_category_id=>2, :description=>"HHHHHHHHHHHHHHHHHHHhh", :unit_type_id=>1}, "1" => {:quantity=>2, :product_category_id=>2, :description=>"IPod Touch 16 GB", :unit_type_id=>1}}
#    @order.providers_attributes = {"0"=>{:name=>"Apple Store", :email=>"fereyji@gmail.com"}, "1"=>{:name=>"Computación Génericos y Suministros", :email=>"fereyjim@yahoo.com.mx"}}

#   test "Should edit product of estimate" do 
#     @order = Order.find(1)
#     @order.products_attributes = {"0" => {:quantity=>1, :product_category_id=>2, :description=>"HHHHHHHHHHHHHHHHHHHhh", :unit_type_id=>1}, "1" => {:quantity=>2, :product_category_id=>2, :description=>"IPod Touch 16 GB", :unit_type_id=>1}}
    
#     assert
    
#   end
  
#   def update
#     assert_equal "Servidores de alto rendimiento IBM", Order.find(1).products.first.description
#     assert_equal "ventas@ibm.com.la", Order.find(1).providers.first.email 
#   end
 
#   def invalid_update
#   #   assert_equal "Macbook air LMF90", Order.find(1).products.first.description
#   #   assert_equal "tonermex@gmail.com", Order.find(1).providers.first.email
# end
 
end
