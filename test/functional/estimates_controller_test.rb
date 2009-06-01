require File.dirname(__FILE__) + '/../test_helper'
 
class EstimatesControllerTest < ActionController::TestCase

  fixtures :users, :people, :addresses, :adscriptions, :user_adscriptions,
    :order_statuses, :orders, :order_products,:currencies, :currency_orders,
    :order_files, :project_types, :projects, :controllers, :permissions

  remote_fixtures

  def setup
    @request.session[:user] = User.find_by_login('alex').id
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

  def test_should_create_estimates_request
    post :create, { :order => {  
                               :products_attributes => [
                                                        { :quantity => 2, :description => 'Macbook air', :product_category_id => 2, :unit_type_id => 1 },
                                                        { :quantity => 1, :description => 'Server IBM', :quantity => 3, :product_category_id => 3, :unit_type_id => 1 }
                                                       ],
                               :providers_attributes => [
                                                         { :name => 'IBM Latinoamérica', :email => 'ventas@ibm.com.la' },
                                                         { :name => 'Mac México', :email => 'mac.ventas@apple.com.mx' }
                                                        ]
                              }
                  }

    assert_redirected_to :action => 'index'
    order_id = Order.last.id + 1 #horrible hack
    assert_equal 2, Order.find(order_id).providers.size
    assert_equal 2, Order.find(order_id).products.size
  end

  def test_should_not_create_estimates_request
    @order = Order.new    

    post :create, { :order => {  
                               :products_attributes => [
                                                        { :quantity => 2, :description => nil, :product_category_id => 2, :unit_type_id => 1 }
                                                       ],
                               :providers_attributes => [
                                                         { :name => 'IBM Latinoamérica', :email => 'ventas@ibm.com.la' }
                                                        ]
                              }
                  }

    assert !@order.valid?
    assert_template 'new'
  end

  def test_should_get_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'
  end

  def test_should_update_estimates_request
    post :update, :id => 1,  :order => {
        :products_attributes => {
                                                        1 => { :id => 1, :quantity => 2, :description => "Servidores de alto rendimiento IBM", :product_category_id => 2, :unit_type_id => 1 }
        },
        :providers_attributes => {
                                                        1 => { :id => 5, :name => 'IBM Latinoamérica', :email => 'ventas@ibm.com.la' }
        }
                              }
                  

    assert_redirected_to :action => 'index'
    assert_equal "Servidores de alto rendimiento IBM", Order.find(1).products.first.description
    assert_equal "ventas@ibm.com.la", Order.find(1).providers.first.email
  end

  def test_should_not_update_estimates_request
    post :update, :id => 1,  :order => {
        :products_attributes => {
                                                        1 => { :id => 1, :quantity => 2, :description => nil, :product_category_id => 2, :unit_type_id => 1 }
        },
        :providers_attributes => {
                                                        1 => { :id => 5, :name => 'IBM Latinoamérica', :email => 'ventas@ibm.com.la' }
        }
                              }
                  

    assert_template 'edit'
    assert_equal "Macbook air LMF90", Order.find(1).products.first.description
    assert_equal "tonermex@gmail.com", Order.find(1).providers.first.email
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
