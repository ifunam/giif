require File.dirname(__FILE__) + '/../test_helper'
 
class ProjectsControllerTest < ActionController::TestCase

  fixtures :users, :projects

  def setup
    session_as('fernando')
  end

  test "should destroy order_file" do
    delete :destroy, :id => 1

    assert :success
    assert_template 'destroy.rjs'
  end
 
end
