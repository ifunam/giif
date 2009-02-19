require File.dirname(__FILE__) + '/../test_helper'

class CurrencyClientTest < ActiveSupport::TestCase
  
  # TODO: Use mock object instead real webservice
  def setup
    @rss = "http://themoneyconverter.com/ES/MXN/rss.xml"
    @currency_client = CurrencyClient.find(@rss)
  end

  test "Should instantiate a currency client with a normal builder" do
    assert_instance_of CurrencyClient, CurrencyClient.new(@rss)
  end
  
  test "Should instantiate a currency client with find" do
   assert_instance_of CurrencyClient, CurrencyClient.find(@rss)
  end

  test "Should get item using the default conversion type (US/MXN)" do
    assert_instance_of Hash, @currency_client.get_item
  end

  test "Should get value using the default conversion type (US/MXN)" do
    assert_not_nil @currency_client.get_value
  end
  
  test "Should convert the currency using the default conversion type (US/MXN)" do
    assert_not_nil @currency_client.convert(10)
  end
end
