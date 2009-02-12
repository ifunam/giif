require File.dirname(__FILE__) + '/../test_helper'

class CurrencyOrderTest < ActiveSupport::TestCase
  should_require_attributes :value

  should_belong_to :order
  should_belong_to :currency
end
