require File.dirname(__FILE__) + '/../test_helper'

class GroupsControllerTest < ActionController::TestCase
  fixtures :groups

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:records)
    assert_template 'index'
  end

   def test_should_get_new
    get :new
    assert_response :success
    assert_not_nil assigns(:record)
    assert_instance_of Group, assigns(:record)
    assert_template 'new'
  end

  def test_should_create_group
    assert_difference('Group.count') do
    post :create, :group => {:name => 'de los norteños' }
    end
     assert_redirected_to group_path(assigns(:record))
   end

   def test_should_show_group
     get :show, :id => Group.find_by_name("Default").id
     assert_response :success
     assert_instance_of Group, assigns(:record)
   end

   def test_should_edit_group
     get :edit, :id => Group.find_by_name("Default").id
     assert_response :success
     assert_instance_of Group, assigns(:record)
     assert_template "edit"
   end

   def test_should_update_group
     put :update, :id => Group.find_by_name("Default").id, :group => { :name => "De los norteños +"}
     assert_redirected_to group_path(assigns(:record))
   end

   def test_should_destroy_group
     Group.find(:all).each do |record|
       delete :destroy, :id => record.id
       assert_redirected_to groups_path
     end
   end
end
