require File.dirname(__FILE__) + '/../test_helper'
 
class CurrenciesControllerTest < ActionController::TestCase
  fixtures :users
 
  def test_should_get_new
    @request.session[:user] = User.find_by_login('fernando').id
    get :new
    assert_response :success
    assert_template 'new'
  end
 
  def test_should_create_new_currency
    @request.session[:user] = User.find_by_login('fernando').id
    post :create, {:currency => { :name => 'Dólar canadiense', :url => 'http://themoneyconverter/ES/DCA/currency.asp'},
                   :currency_order => { :order_id => 1, :currency_id => 2, :value => 14.52}
                  }
    
    assert_template 'currencies/create.rjs'
    assert_equal 14.52, session[:currency_order].value
    assert_equal 1, session[:currency_order].order_id
    assert_equal 2, session[:currency_order].currency_id
  end
 
  def test_should_not_create_new_currency
    @request.session[:user] = User.find_by_login('fernando').id
    post :create, {:currency => {:url => 'http://themoneyconverter/ES/DCA/currency.asp'}
                  }
    assert_template 'currencies/errors.rjs'
  end
 
  def test_should_show_currency_data
    @request.session[:user] = User.find_by_login('fernando').id
    get :show, :id => 3
    
    assert_template 'show'
    assert_not_nil session[:currency_order]
  end
 
  def test_should_change_currency
    @request.session[:user] = User.find_by_login('fernando').id
    get :change_currency
    assert_template 'currencies/change_currency'
  end
 
end
