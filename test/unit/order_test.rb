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

  def test_status_name
    assert_equal 'Sin enviar', @order.status_name
  end

  def test_change_to_sent_status
    @order.change_to_sent_status
    assert_equal 2, @order.order_status_id
  end

  def test_change_to_approved_status
    @order.order_status_id = 2
    @order.change_to_approved_status
    assert_equal 3, @order.order_status_id
  end

  def test_change_to_rejected_status
    @order.order_status_id = 2
    @order.change_to_rejected_status
    assert_equal 4, @order.order_status_id
  end

  def test_add_new_products
    @order.products_attributes = [{:quantity => 2, :description => 'Hub Koesre KIL-09', :price_per_unit => 1234.00, :product_category_id => 1}]
    @order.save
    assert_not_nil @order.products
    assert_equal 'Hub Koesre KIL-09', @order.products.last.description
  end

  def test_update_products
    @order.products_attributes = { "1" => { :quantity => 2, :description => 'Hub Koesre KIL-09', :price_per_unit => 1234.00, :product_category_id => 2} }
    assert_not_nil @order.products
    assert_equal 'Hub Koesre KIL-09', @order.products.last.description
  end

  def test_add_providers
    @order.providers_attributes = [{:name => 'Mac de México'}]
    assert_not_nil @order.providers
    @order.save
    assert_equal 'Mac de México', @order.providers.last.name
  end

  def test_update_providers
    @order.providers_attributes = { "1" => { :name => 'Mac de México City'}}
    assert_not_nil @order.providers
    assert_equal 'Mac de México City', @order.providers.last.name
  end

  def test_add_files
    @order.files_attributes = [ 
                                { :file => @mock_file.read, :content_type => @mock_file.content_type.chomp.to_s, 
                                  :filename => @mock_file.original_filename.chomp, :file_type_id => 2 
                                },
                                { :file => @mock_file.read, :content_type => @mock_file.content_type.chomp.to_s, 
                                  :filename => @mock_file.original_filename.chomp.reverse, :file_type_id => 2 
                                }
                              ]
    @order.save
    assert_equal 3, @order.files.count
  end

  def test_update_files
    @order = Order.find(1)
    file_1 = {:existing => {1 => {'file' => @mock_file, 'file_type_id' => 2}}}
    @order.add_files(file_1)
    @order.save
    @order.add_files(:existing => { @order.order_file.id => {'file' => @mock_file, 'file_type_id' => 2}})
    @order.save
    assert_not_nil @order.order_file
    assert_equal 'Presupuesto_proyecto_CONACYT.pdf' ,@order.order_file.filename
    @order.add_files(:existing => { @order.order_file.id => {'file_type_id' => 2}})
    @order.save
    assert_equal 2 ,@order.order_file.file_type_id
  end

  def test_add_project
    project =     {:new => [{'name' => 'Mac de México', 'key' => '132-LPO', 'project_type_id' => 2}]}
    @order.add_projects(project)
    assert_not_nil @order.project
    assert_equal 'Mac de México', @order.project.name
  end

  def test_update_project
    @order = Order.find(1)
    project = {:existing => {1 => {'name' => 'Clonning the Aguayo idol', 'key' => '132-LPO', 'project_type_id' => 2}}}
    @order.add_projects(project)
    @order.save
    assert_not_nil @order.project
    assert_equal 'Clonning the Aguayo idol', @order.project.name
  end

  def test_should_not_create_order_with_empty_products
    @order = Order.build_valid
    @order.order_providers << OrderProvider.build_valid
    assert !@order.valid?, @order.errors.full_messages
  end

  def test_should_not_create_order_with_empty_providers
    @order = Order.build_valid
    @order.order_products << OrderProduct.build_valid
    assert !@order.valid?, @order.errors.full_messages
  end

  def test_should_add_products
    @order = Order.build_valid
    @order_products = { :new => [ {:quantity => 2,  :price_per_unit => 123.00, :description => 'Servidor marca X'},
                                  {:quantity => 3,  :price_per_unit => 145.70, :description => 'Routers marca Y'}
                                ]
                      }
    @order.add_products(@order_products)
    assert_equal 2, @order.order_products.size
  end

  def test_should_not_add_provider_with_empty_provider
    @order = Order.build_valid
    @order.order_providers << OrderProvider.build_valid
    assert !@order.valid?
    assert_equal ["You should add at least one product", "You should add at least one product"], @order.errors.full_messages
  end

  def test_should_add_providers
    @order = Order.build_valid
    @order_providers = { :new => [ { :name => 'Proveedor A'}, { :name => 'Proveedor B'} ] }
    @order.add_providers(@order_providers)
    assert_equal 2, @order.providers.size
  end

  def test_should_not_add_product_with_empty_product
    @order = Order.build_valid
    @order.order_products << OrderProduct.build_valid
    assert !@order.valid?
    assert_equal ["You should add at least one product", "You should add at least one provider"], @order.errors.full_messages
  end

  def test_should_add_currency_data
    @order = Order.build_valid

    currency = Currency.new(:name => 'Pesos Marcianos', :url => 'someplace')
    currency_order = CurrencyOrder.new(:value => 10.5)
    @order.add_currency_data(currency, currency_order)

    assert !@order.currency_order.nil?
  end

  def test_calculate_total_amount
    @order = Order.first
    assert_equal 56670.0, @order.total_amount
  end
end
