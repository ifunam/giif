require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'

class ProviderTest < ActiveSupport::TestCase
  fixtures :providers, :orders

  should_validate_presence_of :name, :email
#  should_validate_uniqueness_of :name

  def setup
    @date = "2009-07-08".to_date
    @order = Order.find(1)
    @provider = @order.providers.first
    @token = Provider.encrypt_token(@provider.id, @order.id, Provider.find(@provider.id).created_at)
  end


  test "should return encrypt token" do
    assert_equal '486ebc6f12', Provider.encrypt_token(@provider.id, @order.id, @date)  
  end

  test "should authenticate provider with valid params" do
    assert Provider.authenticate?(@provider.id, @order.id, @token)
  end

  test "should not authenticate provider with invalid params" do
    assert !Provider.authenticate?(987, 654, '486ebc6f12')
  end

end
