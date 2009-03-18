require File.dirname(__FILE__) + '/../test_helper'
 
class SessionsControllerTest < ActionController::TestCase
  remote_fixtures
   
  def test_should_index
    get :index
    assert_response :success
    assert_template 'index'
  end
 
  def test_should_signup
    post :signup, :user => {:login => "alex", :password => "valid_password" }
    assert_equal 'Bienvenido(a)!', flash[:notice]
    assert_redirected_to :controller => "orders"
  end
 
  def test_should_not_signup
    post :signup, :user => {:login => "alex", :password => "invalid_password" }
    assert_equal 'El login o password es incorrecto!', flash[:notice]
    assert_redirected_to :action => 'index'
  end
 
  def test_should_logout
    post :signup, :user => {:login => "alex", :password => "valid_password" }
    post :destroy, { :id => session[:user] }
    assert_response :success
    assert_template 'logout'
  end
end
 
