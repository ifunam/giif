require File.dirname(__FILE__) + '/../test_helper'

class OrderProductTest < ActiveSupport::TestCase
   fixtures :users, :order_statuses, :orders, :order_products

  should_require_attributes :quantity, :description, :price_per_unit

  should_only_allow_numeric_values_for :quantity, :price_per_unit
  should_not_allow_zero_or_negative_number_for :quantity, :price_per_unit
  should_not_allow_float_number_for :quantity

  should_belong_to :order#,:user
end
