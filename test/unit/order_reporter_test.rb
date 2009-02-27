require File.dirname(__FILE__) + '/../test_helper'
require 'order_reporter'
class OrderReporterTest < ActiveSupport::TestCase
  fixtures :users, :order_statuses, :orders, :order_products, :providers, :order_providers, :project_types, :projects, :order_files, :currencies, :currency_orders

  def setup
    @order = Order.first
    @report = OrderReporter.new(@order)
  end

  test "Should build an instance of OrderReport" do
    assert_instance_of OrderReporter, OrderReporter.new(@order)
  end

  test "Should build an instance of OrderReport using find and the order ID" do
    assert_instance_of OrderReporter, OrderReporter.find_by_order_id(@order.id)
  end

  test "Should return the order_id" do
    assert_equal '1', @report.order_id
  end

  test "Should return the order date" do
    assert_equal "January  1, 2008", @report.order_date
  end

  test "Should return the remote ip address" do
    assert_equal "192.168.1.1", @report.remote_ip_address
  end

  test "Should return the login of the owner's order" do
    assert_equal "alex", @report.user_login
  end

  test "Should return the fullname of the owner's order" do
    assert_equal "Juárez Robles Jesús Alejandro", @report.user_fullname
  end

  test "Should return the adscription name of the owner's order" do
    assert_equal "Apoyo", @report.user_adscription_name
  end   
  
  test "Should return the phone numberof the owner's order" do
    assert_equal "56225001 ext 289", @report.user_phone
  end   

  test "Should return true if owner's order has an academic responsible" do
    assert @report.user_has_academic_responsible?
  end   
  
  test "Should return the fullname's academic responsible if owner's order has an academic responsible" do
    assert_equal "Ramírez Santiago Guillermo", @report.academic_responsible_fullname
  end
  
  test "Should return the order's products" do
    assert_equal 1, @report.products.size
  end
  
  test "Should return the order's providers" do
    assert_equal 1, @report.providers.size
  end

  test "Should return the order's attached files" do
    assert_equal 1, @report.attachments.size
  end

  test "Should return the order's project" do
    assert_instance_of Project, @report.project
  end

  test "Should return the order's currency" do
    assert_instance_of CurrencyOrder, @report.currency
  end
  
  test "Should return the report's header" do
    assert_equal "Orden de compra No. 1 de Juárez Robles Jesús Alejandro enviada el January  1, 2008", @report.header
  end
  
  test "Should return the report's name" do
    assert_equal "orden_de_compra_alex_1", @report.name
  end

  test "Should return the report's footer" do
    assert @report.footer.include?("Giif - Inst. Fís., UNAM, alex from 192.168.1.1")
  end
end