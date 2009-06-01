require File.dirname(__FILE__) + '/../test_helper'

class ProviderSessionsControllerTest < ActionController::TestCase

  fixtures :users, :people, :addresses, :adscriptions, :user_adscriptions,
    :order_statuses, :orders, :order_products,:currencies, :currency_orders,
    :order_files, :project_types, :projects

  test "provider signup" do
    post :create, :provider_id => 5, :order_id => 1, :token => 'c29fb8acbb'
    
    assert :success
    assert_redirected_to 'estimates/1/files/5/edit'
  end

  test "provider signup fail" do
    post :create, :provider_id => 5, :order_id => 1
    
    assert :success
    assert_redirected_to :controller => 'provider_sessions', :action => 'unauthorized'
  end  

  test "get unauthorized" do
    post :create, :provider_id => 5, :order_id => 1, :token => 'c29fb8acb3'
    
    assert_redirected_to 'provider_sessions/unauthorized'
  end

  test "destroy session" do
    post :destroy
    
    assert :success
    assert_template 'destroy'
  end

end
