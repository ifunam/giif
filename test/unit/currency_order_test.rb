require File.dirname(__FILE__) + '/../test_helper'

class CurrencyOrderTest < ActiveSupport::TestCase
  should_validate_presence_of :value

  should_belong_to :order
  should_belong_to :currency
end
