require File.dirname(__FILE__) + '/../test_helper'

class OrderProductTest < ActiveSupport::TestCase
   fixtures :users, :order_statuses, :orders, :order_products, :unit_types

  should_validate_presence_of :quantity, :description

  should_validate_numericality_of :quantity, :price_per_unit
  should_not_allow_zero_or_negative_number_for :quantity, :price_per_unit
  should_not_allow_float_number_for :quantity

  should_belong_to :order#,:user
  should_belong_to :unit_type
end
