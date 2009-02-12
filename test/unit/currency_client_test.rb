require File.dirname(__FILE__) + '/../test_helper'

class CurrencyClientTest < ActiveSupport::TestCase

  def setup
    @currency_client = CurrencyClient.new("http://themoneyconverter.com/ES/MXN/rss.xml")
  end

  def test_should_get_data_with_find
    @currency_client = CurrencyClient.find("http://themoneyconverter.com/ES/MXN/rss.xml")
    assert_not_nil @currency_client
  end

  def test_should_get_data_with_new
    assert_not_nil @currency_client
  end

  def test_should_get_pesos_value
    assert_not_nil @currency_client.get_value
  end

  def test_should_get_value
    url = "http://themoneyconverter.com/ES/USD/rss.xml"
    @currency_client = CurrencyClient.new(url)

    assert_not_nil @currency_client.get_value
  end

  def test_should_convert_currency
    assert_not_nil @currency_client.convert(100)
  end

end
