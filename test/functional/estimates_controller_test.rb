require File.dirname(__FILE__) + '/../test_helper'

class EstimatesControllerTest < ActionController::TestCase

  fixtures :users, :order_statuses, :orders, :product_categories, 
           :order_products, :controllers, :permissions

  remote_fixtures

  def setup
    session_as('fernando')
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_template 'index'
  end

  def test_should_get_new
    get :new

    assert_response :success
    assert_template 'new'    
  end

  def test_should_create_estimate_request
    post :create, { :order => { 
                              :products_attributes => [ OrderProduct.valid_hash, OrderProduct.valid_hash ],
                              :providers_attributes => [ Provider.valid_hash,  Provider.valid_hash, Provider.valid_hash ]
                              }
                   }
    assert_redirected_to :action => 'index'
  end

  def test_should_not_create_invalid_estimate_request
    post :create, { :order => {  
                              :products_attributes => [ OrderProduct.valid_hash, OrderProduct.invalid_hash ],
                              :providers_attributes => [ Provider.valid_hash, Provider.valid_hash ]
                              }
                  }
    assert_template 'new'
  end

  def test_should_get_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'
  end

  def test_should_update_estimates_request
    post :update, :id => 1,  :order => {
                                :products_attributes => { 1 => OrderProduct.valid_hash(:id=>2) },
                                :providers_attributes => { 1 => Provider.valid_hash(:id=>5) }
                              }
    assert_redirected_to :action => 'index'
  end

  def test_should_not_update_estimates_request
    post :update, :id => 1,  :order => {
      :products_attributes => { 1 => OrderProduct.invalid_hash(:id => 1) },
      :providers_attributes => { 1 => Provider.valid_hash(:id=>5) }
    }

    assert_template 'edit'
  end

  def test_should_destroy_estimate_request
    delete :destroy, :id => 1

    assert :success
    assert_redirected_to 'estimates'
  end

  def test_should_send_data
    put :send_data, :id => 1

    assert :success
    assert_template 'shared/send_order.rjs'
    assert_equal 2, Order.find(1).order_status_id
  end

  def test_should_send_to_order
    put :send_to_order, :id => 5

    assert :success
    assert_redirected_to :controller => 'orders'
    assert_equal 10, Order.find(5).order_status_id
  end
end
