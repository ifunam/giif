# encoding: utf-8

require File.dirname(__FILE__) + '/../../test_helper'

class OrderHelperTest < ActionController::TestCase
  include ActionView::Helpers
  include OrderHelper

  fixtures :order_products, :providers, :order_files, :projects, :orders
  
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

#TODO: Create test for links_for_actions
#   test "should return link_to for a remote action" do
#   end
#TODO
 
  test "should return image_tag() with specific format for an icon" do
    assert_dom_equal %Q(<img title=\"Editar\" src=\"/images/icon_edit.png?1244475393\" alt=\"Icon_edit\" />), icon_tag(Permission.find(2))
  end
  
  test "should return loading indicator for a specific id" do
    assert_equal "$('record_2_loader_indicator').show();", loading_indicator(2)
  end

  test "should return loading complete for a specific id" do
    assert_equal "$('record_2_loader_indicator').hide();", loading_complete(2)
  end

  test "should return row_1 or row_2" do 
    assert_equal 'row_1', set_row_class(0)    
    assert_equal 'row_0', set_row_class(1)    
    assert_equal 'row_1', set_row_class(2)    
    assert_equal 'row_0', set_row_class(3)    
  end

  test "should return image_tag(order) with specific format for a status image" do
    assert_dom_equal %Q(<img src=\"/images/status_solicitud_no_enviada.jpg\" alt=\"Status_solicitud_no_enviada\" />), status_image_tag(Order.find(2))
  end

end
