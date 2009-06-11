require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'
 
class OrdersControllerTest < ActionController::TestCase
  fixtures :users, :people, :addresses, :adscriptions, :user_adscriptions,
    :order_statuses, :orders, :order_products,:currencies, :currency_orders,
    :order_files, :project_types, :projects, :permissions

  remote_fixtures
 
  def setup
    session_as('fernando')
    @mock_file = mock('file')
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_template 'index'
  end
  
  test "should get new" do
    get :new
    assert_response :success
    assert_template 'new'
  end
 
  test "should create new order" do
    post :create,  :order => { 
                              :products_attributes  => [ OrderProduct.valid_hash, OrderProduct.valid_hash ],
                              :providers_attributes => [ Provider.valid_hash,  Provider.valid_hash, Provider.valid_hash ],
                              :files_attributes     => { "0" => {
                                                                 :file => @mock_file, :file_type_id => 2
                                                                }
                                                       },
                              :projects_attributes  => [ Project.valid_hash]
                             }

    assert_redirected_to :action => 'index'
  end

  test "should not create new order with invalid params" do
    post :create,  :order => { 
                              :products_attributes  => [ OrderProduct.invalid_hash, OrderProduct.valid_hash ],
                              :providers_attributes => [ Provider.invalid_hash,  Provider.invalid_hash, Provider.invalid_hash ],
                              :files_attributes     => { "0" => {
                                                                 :file => nil, :file_type_id => nil
                                                                }
                                                       },
                              :projects_attributes  => [ Project.invalid_hash]
                             }

    assert_template 'new'
  end


  test "should send order" do
    post :send_data, { :id => 2}

    assert :success
    assert_template 'send_order.rjs'
  end
 
  test "should get edit" do
    get :edit, :id => 2

    assert_template 'edit'
  end
 
  test "should get html show" do
    get :show, :id => 2

    assert_template 'show'
  end

  test "should get pdf show" do
    get :show, :id => 2, :format => 'pdf'

    assert_template 'show.rpdf'
  end

  test "should update order" do
    post :update, :id => 2,
                   :order => { 
                              :products_attributes  => [ OrderProduct.valid_hash(:id => 2), OrderProduct.valid_hash ],
                              :providers_attributes => [ Provider.valid_hash(:id => 1),  Provider.valid_hash, Provider.valid_hash ],
                              :files_attributes     => { "0" => {
                                                                 :file => @mock_file, :file_type_id => 2
                                                                }
                                                       },
                              :projects_attributes  => [ Project.valid_hash(:id => 2)]
                             }

    assert_redirected_to :action => 'index'
  end

  test "should not update order" do
    post :update, :id => 2,
                   :order => { 
                              :products_attributes  => [ OrderProduct.invalid_hash, OrderProduct.invalid_hash ],
                              :providers_attributes => [ Provider.invalid_hash,  Provider.invalid_hash, Provider.invalid_hash ],
                              :files_attributes     => { "0" => {
                                                                 :file => nil, :file_type_id => nil
                                                                }
                                                       },
                              :projects_attributes  => [ Project.invalid_hash]
                             }

    assert_template 'edit'
  end

  def test_should_destroy
    delete :destroy, :id => 2
    
    assert :success
    assert_redirected_to :action => 'index'
  end
 
  def test_should_destroy_item
    delete :destroy_item, :id => 2, :table => 'order_product'

    assert :success
    assert_template 'destroy_item.rjs'
  end
 
end
