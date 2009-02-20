require File.dirname(__FILE__) + '/../test_helper'
 
class Budget::OrderRequestsControllerTest < ActionController::TestCase
  fixtures :users, :people, :addresses, :adscriptions, :user_adscriptions,
    :order_statuses, :orders, :order_products,:currencies, :currency_orders,
    :file_types, :order_files, :direct_adjudication_types, :acquisitions,
    :project_types, :projects, :budgets
 
  def test_should_get_index
    @request.session[:user] = User.find_by_login('fernando').id
    get :index
 
    assert_response :success
    assert_template 'index'
  end
 
  def test_should_approve_order_request
    @request.session[:user] = User.find_by_login('fernando').id
    post :approve, :id => 2
    
    assert_template 'budget/order_requests'
  end
 
  def test_should_not_approve_order_request
    @request.session[:user] = User.find_by_login('fernando').id
    post :approve, :id => 1
    
    assert_template 'budget/order_requests/errors.rjs'
  end
 
  def test_should_reject_order_request
    @request.session[:user] = User.find_by_login('fernando').id
    post :reject, :id => 2
    
    assert_template 'budget/order_requests'
  end
 
  def test_should_not_reject_order_request
    @request.session[:user] = User.find_by_login('fernando').id
    post :reject, :id => 1
    
    assert_template 'budget/order_requests/errors.rjs'
  end
  
  def test_should_get_new
    @request.session[:user] = User.find_by_login('fernando').id
    post :new, :id => 1
 
    assert_template 'new'
  end
 
  def test_should_get_edit
    @request.session[:user] = User.find_by_login('fernando').id
    get :edit, :id => 1
    
    assert_template 'edit'
  end
 
  def test_should_create_order_request
    @request.session[:user] = User.find_by_login('fernando').id
    post :create, :budget => {:order_id => 4, :user_id => 2, :previous_number => 1, :code => 'WER45', :external_account => 'TFR56-0', :observations => nil}
 
    assert_redirected_to 'budget/order_requests'
  end
 
  def test_should_not_create_order_request
    @request.session[:user] = User.find_by_login('fernando').id
    post :create, :budget => {:order_id => 3, :user_id => nil, :previous_number => 1, :code => 'WER45', :external_account => 0, :observations => nil}
 
    assert_redirected_to 'budget/order_requests'
  end
 
  def test_should_update_order_request
    @request.session[:user] = User.find_by_login('fernando').id
    post :update,{ :id => 3,
                   :budget => {:order_id => 1, :user_id => 2, :previous_number => 1, :code => 'A', :external_account => 'B'}
                 }
    
    assert_redirected_to 'budget/order_requests'
  end
 
  def test_should_not_update_order_request
    @request.session[:user] = User.find_by_login('fernando').id
    post :update,{ :id => 3,
                   :budget => {:order_id => 3, :user_id => 3, :previous_number => nil, :code => 'A', :external_account => '233'}
                 }
    
    assert_redirected_to 'budget/order_requests/new/3'
  end
 
  def test_should_show_currency
    post :show_currency, :id => 2
 
    assert_response 302
  end
 
  def test_show_pdf
    post :show_pdf, :id => 1
  end
 
end
