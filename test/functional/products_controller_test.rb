require File.dirname(__FILE__) + '/../test_helper'

class ProductsControllerTest < ActionController::TestCase
  fixtures :users, :products
  def test_should_destroy_existing_product
    session[:user] = User.find_by_login('fernando').id
    assert Product.find(1)
    
    delete :destroy, :id => 1
    assert_template 'destroy.rjs'
  end
end
