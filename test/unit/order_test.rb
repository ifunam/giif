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
    @mock_file.stubs(:original_filename).returns('Presupuesto_proyecto_CONACYT.pdf')
    @mock_file.stubs(:content_type).returns('application/pdf')
    @mock_file.stubs(:read).returns(StringIO.new(( ("01" *39) + "\n" * 10)).read)
#    @mock.returns(@mock)
  end

  test "Should return the current status" do
    assert_equal 'Solicitud no enviada', @order.current_status
  end

  test "Should change order_status name" do
    @order.sent
    
    assert_equal 4, @order.order_status_id
  end

#   test "Should send emails to each provider" do
#     assert_equal 1, @order.providers.size
#   end
    
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

  test "Should add new products" do 
    assert_equal 1, @order.products.size
    @order.products_attributes = {"0" => {:quantity=>1, :product_category_id=>2, :description=>"IPod nano 32GB negro", :unit_type_id=>1}, "1" => {:quantity=>2, :product_category_id=>2, :description=>"IPod nano 32GB negro", :unit_type_id=>1}}
    @order.save
    assert_equal 3, @order.products.size
    assert_equal 'IPod nano 32GB negro', @order.products.last.description
  end

  test "Should update product" do 
    @product = @order.products.first
    @order.products_attributes = {"0" => {:id => @product.id, :quantity=>1, :product_category_id=>2, :description=>"Product description updated", :unit_type_id=>1}}
    @order.save
    assert_equal 'Product description updated', @order.products.first.description
  end

  test "Should add new providers" do
    assert_equal 1, @order.providers.size
    @order.providers_attributes = {"0"=>{:name=>"Apple Store", :email=>"fereyji@gmail.com"}, "1"=>{:name=>"Computación Génericos y Suministros", :email=>"fereyjim@yahoo.com.mx"}}
    @order.save
    assert_equal 3, @order.providers.size
    assert_equal 'Computación Génericos y Suministros', @order.providers.last.name
  end

  test "Should update provider" do
    @provider = @order.providers.first
    @order.providers_attributes = {"0"=>{:id => @provider.id, :name=>"Provider name updated", :email=>"fereyji@gmail.com"}}
    @order.save
    assert_equal 'Provider name updated', @order.providers.first.name
  end

  #  test "Should add new files" do
  #     @order.file_attributes = {  :file => @mock_file, :file_type_id => 2 }
  #     @order.save
  #     assert_equal 1, @order.files.count
  # end

#   # test "Should update existent files" do
#   #    @order.files_attributes = { 
#   #        {  :id => 1,
#   #             :file => @mock_file, :file_type_id => 2
#   #            }
#   #     }
#   #     @order.save
#   #     assert_equal "fdp.TYCANOC_otceyorp_otseupuserP", @order.files.last.filename
#   #   end
#   # 
  
  test "Should add new project" do
    assert_equal 1, @order.projects.size
    @order.projects_attributes = {"0" => { :name => 'Alpha project', :key => '132-LPO', :project_type_id => 2 }}
    @order.save
    assert_equal 2, @order.projects.size
    assert_equal 'Alpha project', @order.projects.last.name
  end

  test "Should update projects" do
    @project = @order.projects.first
    @order.projects_attributes = { "0" => { :id => @order.id, :name => 'Project updated', :key => '132-LPO', :project_type_id => 2 } }
    @order.save
    assert_equal 'Project updated', @order.projects.first.name
  end

#   test "Should not be a valid order if it doesn't has at least one product" do 
#     order = Order.new(:user_id => 2, :order_status_id => 1, :id => 5)
#     order.providers_attributes = {"0" => {:id => 4, :name => 'Proveedor A'}}
#     assert !order.valid?
#     assert_equal 1, order.providers.size
#     assert_equal "", order.errors.full_messages
#     assert !order.errors.full_messages.nil?
#     assert order.errors.full_messages.include?("Providers email can\'t be blank")
#   end

#   test "Should not be a valid order if It does'nt havee at least one provider" do 
#     order_p = Order.new
#     order_p.products_attributes = { "0" => {:quantity => 2,  :price_per_unit => 123.00, :description => 'Servidor marca X', :product_category_id => 1} }
#     assert !order_p.valid?
#     assert !order_p.errors.full_messages.nil?
#     assert_equal "", order_p.errors.full_messages
#     assert order_p.errors.full_messages.include?("Products product category can\'t be blank")
#   end

  test "Should calculate total_price for existent order" do
    assert_equal 56670.0, @order.total_price
  end
end
