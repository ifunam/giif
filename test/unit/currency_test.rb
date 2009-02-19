require File.dirname(__FILE__) + '/../test_helper'

class CurrencyTest < ActiveSupport::TestCase
  fixtures :currencies
  should_require_attributes :name
  should_have_many :currency_orders
end
