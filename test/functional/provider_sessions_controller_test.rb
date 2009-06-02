require File.dirname(__FILE__) + '/../test_helper'

class ProviderSessionsControllerTest < ActionController::TestCase

  fixtures :users, :order_statuses, :orders, :order_products,
  :providers, :order_files

  test "provider signup" do
    post :create, :provider_id => 5, :order_id => 1, :token => '6f1727190c'
    assert :success
    assert_redirected_to edit_estimate_file_path( :estimate_id => 1, :id => 5)
  end

  test "provider signup fail" do
    post :create, :provider_id => 5, :order_id => 1
    assert_response 401
    assert_template 'unauthorized_message'
  end  

  test "get unauthorized" do
    post :create, :provider_id => 5, :order_id => 1, :token => 'c29fb8acb3'
    assert_response 401
    assert_template 'unauthorized_message'
  end

  test "destroy session" do
    post :destroy
    assert :success
    assert_template 'destroy'
  end
end
