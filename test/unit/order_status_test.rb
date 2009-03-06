require File.dirname(__FILE__) + '/../test_helper'

class OrderStatusTest < ActiveSupport::TestCase
  fixtures :order_statuses

  should_validate_presence_of :name
  should_validate_uniqueness_of :name
end
