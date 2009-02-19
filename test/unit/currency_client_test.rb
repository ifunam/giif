require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'
class CurrencyClientTest < ActiveSupport::TestCase
  
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
    @currency_client.expects(:item).returns({ :category => "América del Norte",
                                               :pubDate => "Thu Feb 19 09:01:21 -0700 2009",
                                               :title => "USD/MXN",
                                               :guid => "http://themoneyconverter.com/ES/MXN/USD.aspx",
                                               :link => "http://themoneyconverter.com/ES/MXN/USD.aspx",
                                               :description => "1 Peso Mexicano = 0.06868 Dólar Americano"
                                               })
    assert_instance_of Hash, @currency_client.item
  end

  test "Should get value using the default conversion type (US/MXN)" do
    @currency_client.expects(:value).returns(0.06868)
    assert_equal 0.06868, @currency_client.value
  end
  
  test "Should convert the currency using the default conversion type (US/MXN)" do
    @currency_client.expects(:convert).with(10).returns(150.06)
    assert_equal 150.06, @currency_client.convert(10)
  end
end
