require File.dirname(__FILE__) + '/../test_helper'
require 'notifier'
require 'mocha'

class OrderFileObserverTest < ActiveSupport::TestCase

  fixtures :users, :order_statuses, :orders, :product_categories, :order_products, 
  :providers, :order_providers, :project_types, :projects, :file_types, :order_files, :unit_types

  remote_fixtures
  
  test "send estimate response from provider to user" do
    @order = Order.find(8)
    @order.update_attributes(:files_attributes => { "0" =>  { :file => @mock_file, :file_type_id => 2 }})
    @order.save
    assert_equal 2, @order.order_status_id

#     response = Notifier.create_estimate_response_from_provider(Order.first, Provider.first)
#     assert_equal '[GIIF] Solicitud de cotización respondida', response.subject    
  end

end
