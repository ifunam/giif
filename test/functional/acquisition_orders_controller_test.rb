require File.dirname(__FILE__) + '/../test_helper'
 
class Acquisition::OrdersControllerTest < ActionController::TestCase
  fixtures :users, :people, :addresses, :adscriptions, :user_adscriptions,
           :order_statuses, :orders, :order_products,:currencies, :currency_orders,
           :file_types, :order_files, :direct_adjudication_types, :acquisitions,
           :permissions, :project_types, :projects

  remote_fixtures

  def setup
    session_as('fernando')
  end
 
  test "should get index" do
    get :index

    assert_response :success
    assert_template 'index'
  end
 
  test "should get new" do
    get :new, :id => 4

    assert_response :success
    assert_template 'new'
  end
 
  test "should create acquiaition data" do
    post :create, :acquisition => Acquisition.valid_hash, :id => 4

    assert_response :redirect
    assert_redirected_to 'acquisition/orders'
  end
 
  test "should not create acquisition data" do
    post :create, :acquisition => Acquisition.invalid_hash, :id => 4

    assert_template 'new'
  end
 
  test "should get show acquisition data" do
    get :show, :id => 4

    assert :success 
    assert_template 'show'
  end
 
  test "should show acquisition data in pdf format" do
    post :show, :format => 'pdf', :id => 4
    
    assert :success
    assert_template 'show.rpdf'
  end
 
  test "should get edit acquisition data" do
    get :edit, :id => 4
 
    assert :success
    assert_template 'edit'
  end
 
  test "should update acquisition data" do
    post :update, {:id => 4, :acquisition => Acquisition.valid_hash }
    
    assert_redirected_to 'acquisition/orders'
  end

end
 
