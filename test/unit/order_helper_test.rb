require File.dirname(__FILE__) + '/../test_helper'
require 'order_helper'

class OrderHelperTest < ActiveSupport::TestCase
  include OrderHelper
  test "Should return the value for *x* coordinate" do
      assert_equal "150",  get_coordinated_for_x(1)
      assert_equal "222",  get_coordinated_for_x(2)
      assert_equal "306",  get_coordinated_for_x(3)
      assert_equal "387",  get_coordinated_for_x(4)
      assert_equal "150",  get_coordinated_for_x(5)
  end
  
  test "Should return the value for *y* coordinate" do
      assert_equal "285",  get_coordinated_for_y(5)
      assert_equal "295",  get_coordinated_for_y(1)
  end
end