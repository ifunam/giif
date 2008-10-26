require File.dirname(__FILE__) + '/../test_helper'

class OrderStatusTest < ActiveSupport::TestCase
  fixtures :order_statuses

  should_require_attributes :name
  should_require_unique_attributes :name
end
