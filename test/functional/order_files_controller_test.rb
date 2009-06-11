require File.dirname(__FILE__) + '/../test_helper'
 
class OrderFilesControllerTest < ActionController::TestCase

  fixtures :users, :order_files

  def setup
    session_as('fernando')
  end

  test "should destroy order_file" do
    delete :destroy, :id => 1

    assert :success
    assert_template 'destroy.rjs'
  end
 
end
