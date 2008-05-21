require File.dirname(__FILE__) + '/../test_helper'

class SessionsControllerTest < ActionController::TestCase
  fixtures :users

  def test_should_index
    get :index
    assert_response :success
    assert_template 'index'
  end

  def test_should_signup
    post :signup, :user => {:login => "fernando", :password => "maltiempo" }
    assert_equal 'Bienvenido (a)!', flash[:notice]
    assert_redirected_to :controller => "order_requests"
  end

  def test_should_not_signup
    post :signup, :user => {:login => "fernando", :password => "badpassword" }
    assert_equal 'El login o password es incorrecto!', flash[:notice]
    assert_redirected_to :action => 'index'
  end

  def test_should_logout
    post :signup, :user => {:login => "fernando", :password => "maltiempo" }
    post :destroy, { :id => session[:user] }
    assert_response :success
    assert_template 'logout'
  end
end
