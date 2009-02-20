require File.dirname(__FILE__) + '/../test_helper'
 
class GroupsControllerTest < ActionController::TestCase
  fixtures :users, :groups
 
   def test_should_get_index
     @request.session[:user] = User.find_by_login('fernando').id
     get :index
     assert_response :success
     assert_template 'index'
   end
 
   def test_should_get_new
     @request.session[:user] = User.find_by_login('fernando').id
     get :new
     assert_response :success
     assert_not_nil assigns(:record)
     assert_instance_of Group, assigns(:record)
     assert_template 'new'
   end
 
   def test_should_create_group
     @request.session[:user] = User.find_by_login('fernando').id
     assert_difference('Group.count') do
       post :create, :group => {:name => 'de los norteños' }
     end
     assert_redirected_to group_path(assigns(:record))
   end
 
   def test_not_create_group
     @request.session[:user] = User.find_by_login('fernando').id
     post :create, :group => {:name => nil }
     assert_response :success
     assert_template 'new'
   end
 
   def test_should_show_group
     @request.session[:user] = User.find_by_login('fernando').id
     get :show, :id => Group.find_by_name("Default").id
     assert_response :success
     assert_instance_of Group, assigns(:record)
   end
 
   def test_should_edit_group
     @request.session[:user] = User.find_by_login('fernando').id
     get :edit, :id => Group.find_by_name("Default").id
     assert_response :success
     assert_instance_of Group, assigns(:record)
     assert_template "edit"
   end
 
   def test_should_update_group
     @request.session[:user] = User.find_by_login('fernando').id
     put :update, :id => Group.find_by_name("Default").id, :group => { :name => "De los norteños +"}
     assert_redirected_to group_path(assigns(:record))
   end
 
   def test_not_update_group
     @request.session[:user] = User.find_by_login('fernando').id
     put :update, :id => Group.find_by_name("Default").id, :group => { :name => nil}
     assert_response :success
     assert_template "edit"
   end
 
   def test_should_destroy_group
     @request.session[:user] = User.find_by_login('fernando').id
     Group.find(:all).each do |record|
       delete :destroy, :id => record.id
       assert_redirected_to groups_path
     end
   end
end
