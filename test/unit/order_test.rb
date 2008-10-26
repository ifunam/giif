require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class OrderTest < ActiveSupport::TestCase
  fixtures :users, :order_statuses, :orders, :order_products, :providers, :order_providers
#  should_require_attributes :date,  :order_status_id
 # should_only_allow_numeric_values_for :id, :user_id, :order_status_id, :user_incharge_id

#  should_belong_to :order_status
  should_have_many :order_products, :order_providers, :providers, :order_files, :projects

  def setup
    @order = Order.new
    @order.attributes = {
                                   'user_id' => 2,
                                   'date' => '2008-04-19',
                                   'order_status_id' => 1
    }
#     @order_products = OrderProduct.new
#     @order_products.attributes = {
#                                       'order_id' => 3,
#                                       'quantity' => 1,
#                                       'description' => 'Hub Koesre KIL-09',
#                                       'price_per_unit' => 1234.00}
#     @order_providers = OrderProvider.new
#     @order_providers.attributes = {
#                                       'order_id' => 3,
#                                       'provider_id' => '',
#                                       }
#     @order_files = OrderFiles.new
#     @order_files.attributes = {
#                                        'order_id' => 3,
#                                        'file_type_id' => 2,
#                                        'file' => '',
#                                        'content_type' => 'UTF-8',
#                                        'filename' => 'filename'
#                                        }
#     @order_projects = Project.new
#     @order_projects.attributes = {
#                                       'order_id' => 3,
#                                       'project_type_id' => 2,
#                                       'name' => 'Proyecto de investigación en ciencia de materiales',
#                                       'key' => '623-JH'}
  end

  def test_status_name
    assert_equal 'En proceso', @order.status_name
  end

  def test_change_to_sent_status
    @order.change_to_sent_status
    assert_equal 2, @order.order_status_id
  end

  def test_add_products
    products = { :new => [{:order_id => 2,  :quantity => 2, :description => 'Hub Koesre KIL-09', :price_per_unit => 1234.00}]}
    @order.add_products(products)
    assert_not_nil @order.order_products
    assert_equal 'Hub Koesre KIL-09', @order.order_products.first.description
  end

  def test_update_products
    products = {:existing => { 1 => { :order_id => 1,  :quantity => 2, :description => 'Hub Koesre KIL-09', :price_per_unit => 1234.00}}}
    @order.add_products(products)
    assert_not_nil @order.order_products
    assert_equal 'Hub Koesre KIL-09', @order.order_products.first.description
  end

  def test_add_providers
    providers = { :new => [{:name => 'Mac de México'}]}
    @order.add_providers(providers)
    assert_not_nil @order.providers
    assert_equal 'Mac de México', @order.providers.first.name
  end

  def test_update_providers
    @order = Order.find(1)
    @order.add_providers({ :existing => {1 => { :name => 'Mac de México'}}})
    assert_not_nil @order.providers
    assert_equal 'Mac de México', @order.providers.find(1).name
  end

  def test_add_files
    file = mock('file')
    file.stubs(:original_filename).returns('Presupuesto_proyecto_CONACYT.pdf')
    file.stubs(:content_type).returns('application/pdf')
    file.stubs(:read).returns('file_content(a lot of bits here...)')
    files = { :new => [{'file' => file, 'file_type_id' => 2}]}
     @order.add_files(files)
    assert_not_nil @order.order_files
    assert_equal 2, @order.order_files.last.file_type_id
  end

  def test_update_files
    @order = Order.find(1)
    file = mock('file')
    file.stubs(:original_filename).returns('Presupuesto_proyecto_CONACYT.pdf').times(2)
    file.stubs(:content_type).returns('application/pdf')
    file.stubs(:read).returns('file_content(a lot of bits here...)')
    files = { :new => [{'file' => file, 'file_type_id' => 2}]}
    @order.add_files(files)
    @order.save
    @order.add_files(:existing => { @order.order_files.first.id => {'file' => file, 'file_type_id' => 2}})
    @order.save
    assert_not_nil @order.order_files
    assert_equal 'Presupuesto_proyecto_CONACYT.pdf' ,@order.order_files.first.filename
end

  def test_add_projects
    projects =     {:new => [{'name' => 'Mac de México', 'key' => '132-LPO', 'project_type_id' => 2}]}
    @order.add_projects(projects)
    assert_not_nil @order.projects
    assert_equal 'Mac de México', @order.projects.last.name
  end

  def test_update_projects
    @order = Order.find(1)
    projects = {:existing => {1 => {'name' => 'Clonning the Aguayo idol', 'key' => '132-LPO', 'project_type_id' => 2}}}
    @order.add_projects(projects)
    @order.save
    assert_not_nil @order.projects
    assert_equal 'Clonning the Aguayo idol', @order.projects.find(1).name
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
end
