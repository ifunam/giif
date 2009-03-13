require File.dirname(__FILE__) + '/../test_helper'
class OrderTest < ActiveSupport::TestCase
  fixtures :users, :order_statuses, :orders, :product_categories, :products, :order_products, 
  :providers, :order_providers, :project_types, :projects, :file_types, :order_files

  should_have_many :order_products, :order_providers, :providers
  should_have_one :order_file, :project, :currency_order, :budget, :acquisition

  def setup
    @order = Order.first
    @mock_file = mock('file')
    @mock_file.stubs(:original_filename).returns('Presupuesto_proyecto_CONACYT.pdf')
    @mock_file.stubs(:content_type).returns('application/pdf')
    @mock_file.stubs(:read).returns(StringIO.new(( ("01" *39) + "\n" * 10)).read)
  end

  test "Should return the current status" do
    assert_equal 'Sin enviar', @order.current_status
  end

  test "Should send the order" do 
    @order.sent
    assert_equal 2, @order.order_status_id
  end

  test "Should approve the order" do 
    @order.order_status_id = 2
    @order.approve
    assert_equal 3, @order.order_status_id
  end

  test "Should rejecte the order" do 
    @order.order_status_id = 2
    @order.reject
    assert_equal 4, @order.order_status_id
  end

  test "Should add new products" do 
    @order.products_attributes = [ { :quantity => 2, :description => 'Hub Koesre KIL-09', :price_per_unit => 1234.00, :product_category_id => 1} ]
    @order.save
    assert_not_nil @order.products
    assert_equal 'Hub Koesre KIL-09', @order.products.last.description
  end

  test "Should update products" do 
    @order.products_attributes = { "1" => { :quantity => 2, :description => 'Hub Koesre KIL-09', :price_per_unit => 1234.00, :product_category_id => 2 } }
    assert_not_nil @order.products
    assert_equal 'Hub Koesre KIL-09', @order.products.last.description
  end

  test "Should add new providers" do
    @order.providers_attributes = [ { :name => 'Mac de México' } ]
    assert_not_nil @order.providers
    @order.save
    assert_equal 'Mac de México', @order.providers.last.name
  end

  test "Should update providers" do
    @order.providers_attributes = { "1" => { :name => 'Mac de México City'}}
    assert_not_nil @order.providers
    assert_equal 'Mac de México City', @order.providers.last.name
  end

  # test "Should add new files" do
  #     @order.files_attributes = [ 
  #       { 
  #         :file => @mock_file, :file_type_id => 2 
  #       },
  #       # { 
  #       #     :file => @mock_file,  :file_type_id => 1
  #       #   }
  #     ]
  #     @order.save
  #     assert_equal 2, @order.files.count
  #   end
  # 
  #   test "Should update existent files" do
  #     @order.files_attributes = { 
  #       1 => { 
  #              :file => @mock_file, :file_type_id => 2
  #             }
  #     }
  #     @order.save
  #     assert_equal "fdp.TYCANOC_otceyorp_otseupuserP", @order.files.last.filename
  #   end

  test "Should add new project" do
      # Fix it => Test project_attributes  
       @order.projects_attributes = [{ :name => 'Alpha project', :key => '132-LPO', :project_type_id => 2 }]
       @order.save
       assert_not_nil @order.project
       assert_equal 'Alpha project', @order.projects.last.name
   end
  
  test "Should add new projects" do
     @order.projects_attributes = [ { :name => 'Alpha project', :key => '132-LPO', :project_type_id => 2}  ]
     assert_not_nil @order.projects
     assert_equal 'Alpha project', @order.projects.last.name
  end
  
  test "Should update projects" do
    @order.projects_attributes = { 1 => { :name => 'Beta project', :key => '132-LPO', :project_type_id => 2 } }
    @order.save
    assert_not_nil @order.project
    assert_equal 'Beta project', @order.projects.last.name
   end

  test "Should not create order with empty products" do
    @order = Order.build_valid
    @order.order_providers << OrderProvider.build_valid
    assert !@order.valid?, @order.errors.full_messages
  end

  test "Should not create order with empty providers" do
    @order = Order.build_valid
    @order.order_products << OrderProduct.build_valid
    assert !@order.valid?, @order.errors.full_messages
  end

  test "Should add product for an existent order" do
    @order.products_attributes = [ {:quantity => 2,  :price_per_unit => 123.00, :description => 'Servidor marca X', :product_category_id => 1},
                                    {:quantity => 3,  :price_per_unit => 145.70, :description => 'Routers marca Y', :product_category_id => 2}
                                  ]
    @order.save
    assert_equal 3, @order.order_products.count
  end

  test "Should not be a valid order if It does'nt hace at least one product" do 
    order = Order.build_valid
    order.order_providers << OrderProvider.build_valid
    assert !order.valid?
    assert_equal ["You should add at least one product", "You should add at least one product"], order.errors.full_messages
  end

  test "Should add providers to an existent order" do
    @order.providers_attributes = [ { :name => 'Proveedor A'}, { :name => 'Proveedor B'} ]
    @order.save
    assert_equal 3, @order.providers.size
  end

  test "Should not be a valid order if It does'nt havee at least one provider" do 
    order = Order.build_valid
    order.order_products << OrderProduct.build_valid
    assert !order.valid?
    assert_equal ["You should add at least one product", "You should add at least one provider"], order.errors.full_messages
  end

  test "Should add currency into a new order" do
    order = Order.build_valid
    order.currency_order_attributes = { :value => 10.5, :currency_id => 1}
    order.save
    assert_equal 10.5, order.currency_order.value
  end

  test "Should calculate total_amount for existent order" do
    assert_equal 56670.0, @order.total_amount
  end
end
