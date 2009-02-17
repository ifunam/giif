require File.dirname(__FILE__) + '/../test_helper'

class Budget::OrderRequestsControllerTest < ActionController::TestCase
  fixtures :users, :orders, :budgets

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
    post :create, :budget => {:order_id => 1, :user_id => 2, :previous_number => 1, :code => 'WER45', :external_account => 'TFR56-0', :observations => nil}      

    assert_redirected_to 'budget/order_requests'
  end

#   def test_should_not_create_order_request
#     @request.session[:user] = User.find_by_login('fernando').id
#     post :create, :budget => {:order_id => 1, :user_id => nil, :previous_number => 1, :code => 'WER45', :external_account => nil, :observations => nil}      

#     assert_redirected_to 'budget/order_requests/new/1'
#   end

  def test_should_update_order_request
    @request.session[:user] = User.find_by_login('fernando').id
    post :update,{ :id => 1,
                   :budget => {:order_id => 1, :user_id => 2, :previous_number => 1, :code => 'A', :external_account => 'B'}      
                 }
    
    assert_redirected_to 'budget/order_requests'
  end

  def test_should_not_update_order_request
    @request.session[:user] = User.find_by_login('fernando').id
    post :update,{ :id => 1,
                   :budget => {:order_id => 1, :user_id => nil, :previous_number => 1, :code => 'A', :external_account => 'B'}      
                 }
    
    assert_redirected_to 'budget/order_requests/new/1'
  end

  def test_show_currency
    post :show_currency, :id => 1
    
    assert_template :partial => 'currency_info'
  end

  def test_show_pdf
    post :show_pdf, :id => 1
  end

end
