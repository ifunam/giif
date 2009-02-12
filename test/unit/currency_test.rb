require File.dirname(__FILE__) + '/../test_helper'

class CurrencyTest < ActiveSupport::TestCase
  should_require_attributes :name, :url
  should_have_many :currency_orders
end
