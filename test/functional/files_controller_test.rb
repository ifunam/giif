require File.dirname(__FILE__) + '/../test_helper'

class FilesControllerTest < ActionController::TestCase
  test "should get edit" do
    post :create, :provider_id => 5, :order_id => 1, :token => '6f1727190c'
#    post :edit, :estimate_id => 2, :provider_id => 5, :order_id => 1, :token => '6f1727190c'
    
    assert_template 'edit'
  end
end
