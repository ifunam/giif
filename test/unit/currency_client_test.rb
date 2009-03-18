# encoding: utf-8

require File.dirname(__FILE__) + '/../test_helper'
require 'mocha'
class CurrencyClientTest < ActiveSupport::TestCase
  
  def setup
    @rss = "http://themoneyconverter.com/MXN/USD/rss.xml"
    @currency_client = CurrencyClient.find(@rss)
  end

  test "Should instantiate a currency client with a normal builder" do
    assert_instance_of CurrencyClient, CurrencyClient.new(@rss)
  end
  
  test "Should instantiate a currency client with find" do
    assert_instance_of CurrencyClient, CurrencyClient.find(@rss)
  end

  test "Should get item using the default conversion type (US/MXN)" do
    @currency_client.expects(:item).returns({:guid=>"http://themoneyconverter.com/ES/USD/MXN.aspx",
                                              :description=>"1 Dólar Americano = 14.74131 Peso Mexicano", 
                                              :link=>"http://themoneyconverter.com/ES/USD/MXN.aspx",
                                              :title=>"MXN/USD",
                                              :category=>"América del Norte", 
                                              :pubDate=>"Thu Feb 19 18:05:04 -0600 2009"
                                            })
    assert_instance_of Hash, @currency_client.item
  end

  test "Should get value using the default conversion type (US/MXN)" do
    @currency_client.expects(:value).returns(14.72247)
    assert_equal 14.72247, @currency_client.value
  end
  
  test "Should convert the currency using the default conversion type (US/MXN)" do
    @currency_client.expects(:convert).with(10).returns(147.4131)
    assert_equal 147.4131, @currency_client.convert(10)
  end
end
