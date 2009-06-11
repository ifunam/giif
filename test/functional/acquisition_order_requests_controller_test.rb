require File.dirname(__FILE__) + '/../test_helper'
 
class Acquisition::OrderRequestsControllerTest < ActionController::TestCase
  fixtures :users, :people, :addresses, :adscriptions, :user_adscriptions,
           :order_statuses, :orders, :order_products,:currencies, :currency_orders,
           :file_types, :order_files, :direct_adjudication_types, :acquisitions

  def setup
    session_as('fernando')
  end
 
#   def test_should_get_index
#     @request.session[:user] = User.find_by_login('alex').id

#     get :index

#      assert_response :success
#      assert_template 'index'
#   end
 
#   def test_should_get_new
#     @request.session[:user] = User.find_by_login('fernando').id
#     get :new, :id => 1
#     assert_response :success
#     assert_template 'new'
#   end
 
#   def test_should_post_into_create
#     @request.session[:user] = User.find_by_login('fernando').id
#     post :create, :acquisition =>{ :order_id => 1, :is_subcomittee_invitation => false, :direct_adjudication_type_id => 2, :is_subcomittee_bid => false}
#     assert_response :redirect
#     assert_redirected_to 'acquisition/order_requests'
#   end
 
#   def test_should_not_create_acquisition_data
#     @request.session[:user] = User.find_by_login('fernando').id
#     post :create, :acquisition =>{ :order_id => 3, :direct_adjudication_type_id => 1, :is_subcomittee_bid => false}
#     assert_response :redirect
#     assert_redirected_to 'acquisition/order_requests/new/3'
#   end
 
#   def test_should_get_show
#     @request.session[:user] = User.find_by_login('fernando').id
#     get :show, :id => 3
 
#     assert_template 'show'
#   end
 
#   def should_show_pdf
#     @request.session[:user] = User.find_by_login('fernando').id
#     post :show_pdf
#     assert :success
#   end
 
#   def test_should_edit_acquisition_data
#     @request.session[:user] = User.find_by_login('fernando').id
#     get :edit, :id => 3
 
#     assert_template 'edit'
#   end
 
#   def test_should_update_acquisition_data
#     @request.session[:user] = User.find_by_login('fernando').id
#     post :update, {:id => 3,
#                    :acquisition => { :order_id => 3, :user_id => 3, :direct_adjudication_type_id => 2, :is_subcomittee_invitation => true, :is_subcomittee_bid => false
#                                    }
#                   }
    
#     assert_redirected_to 'acquisition/order_requests'
#   end
 
#   def test_should_not_update_acquisition_data
#     @request.session[:user] = User.find_by_login('fernando').id
#     post :update, {:id => 3,
#                    :acquisition => { :order_id => 3, :user_id => nil, :direct_adjudication_type_id => 2, :is_subcomittee_invitation => true, :is_subcomittee_bid => true}
#                   }
    
#     assert_redirected_to 'acquisition/order_requests/new/3'
#   end
 
end
 
