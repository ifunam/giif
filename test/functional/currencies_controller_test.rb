require File.dirname(__FILE__) + '/../test_helper'
 
class CurrenciesControllerTest < ActionController::TestCase
  fixtures :users
 
  test "should_get_new" do
    session_as('fernando')
    get :show_currency, :id => 2

    assert_response :success
    assert_template 'show.rjs'
  end

  test "should_change_currency" do
    session_as('fernando')
    get :change_currency

    assert_response :success
    assert_template 'change_currency.rjs'
  end

  test "should_create_new_currency" do
    session_as('fernando')
    get :create_currency, {:currency_order => CurrencyOrder.valid_hash, :currency => Currency.valid_hash}

    assert_response :success
    assert_template 'create_currency.rjs'
  end

  test "should_not_create_new_currency" do
    session_as('fernando')
    get :create_currency, { :currency_order => CurrencyOrder.invalid_hash, :currency => Currency.invalid_hash}

    assert_response :success
    assert_template 'errors.rjs'
  end
  
end
