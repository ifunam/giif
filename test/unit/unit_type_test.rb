require File.dirname(__FILE__) + '/../test_helper'

class UnitTypeTest < ActiveSupport::TestCase
  fixtures :unit_types

  should_validate_presence_of :name
  should_validate_uniqueness_of :name

  should_have_many :order_products
end
