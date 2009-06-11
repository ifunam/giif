require File.dirname(__FILE__) + '/../test_helper'
 
class OrderProductsControllerTest < ActionController::TestCase

  fixtures :users, :order_products

  def setup
    session_as('fernando')
  end

  test "should destroy order_file" do
    delete :destroy, :id => 1

    assert :success
    assert_template 'destroy.rjs'
  end
 
end
