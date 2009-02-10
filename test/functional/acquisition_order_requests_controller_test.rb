require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class Acquisition::OrderRequestsControllerTest < ActionController::TestCase
  fixtures :users, :people, :addresses, :adscriptions, :user_adscriptions, :order_statuses, :orders, :order_products
  
  def test_should_get_new
      @request.session[:user] = User.find_by_login('fernando').id
      get :new, :id => 1
      assert_response :success
      assert_template 'new'
  end


  def test_should_post_into_create
      @request.session[:user] = User.find_by_login('fernando').id
      post :create, :acquisition =>{ :order_id => 1, :is_subcomittee_invitation => false, :direct_adjudication_type_id => 2, :is_subcomittee_bid => false}
      assert_response :redirect
      assert_template 'index'
  end
  
end