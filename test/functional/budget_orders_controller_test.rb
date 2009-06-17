require File.dirname(__FILE__) + '/../test_helper'
class Budget::OrdersControllerTest < ActionController::TestCase

  fixtures :users, :people, :addresses, :adscriptions, :user_adscriptions,
  :order_statuses, :orders, :order_products,:currencies, :currency_orders,
  :file_types, :order_files, :direct_adjudication_types, :acquisitions,
  :project_types, :projects, :budgets, :controllers, :permissions

  remote_fixtures

  def setup
    session_as('fernando')
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_template 'index'
  end

  test "should approve order request" do
    post :approve, :id => 6
    assert_template 'budget/orders/replace_data.rjs'
  end

  test "should not approve order request" do
    post :approve, :id => 5
    assert_template 'budget/orders/errors.rjs'
  end

  test "should reject order request" do
    post :reject, :id => 6
    assert_template 'replace_data.rjs'
  end

  test "should not reject order request" do
    post :reject, :id => 1
    assert_template 'budget/orders/errors.rjs'
  end

  test "should get new" do
    get :new, :id => 6
    assert_template 'new'
  end

  test "should get edit" do
    get :edit, :id => 6
    assert_template 'edit'
  end

  test "should create order request" do
    post :create, :budget => Budget.valid_hash, :id => 4
    assert_redirected_to 'budget/orders'
  end

  test "should not create order request" do
    post :create, :budget =>  Budget.invalid_hash, :id => 6
    assert_template 'new'
  end

  test "should update order request" do
    post :update, :id => 3, :budget => Budget.valid_hash
    assert_redirected_to 'budget/orders'
  end

  test "should not update order request" do
    post :update, :id => 3, :budget => Budget.invalid_hash
    assert_template 'new'
  end

  test "should show order in html format" do
    post :show, :id => 6
    assert_template 'show'
   end

  test "should show order in pdf format" do
     post :show, :id => 6, :format => 'pdf'
    assert_template 'show.rpdf'
   end

end
