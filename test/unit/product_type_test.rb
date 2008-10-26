require File.dirname(__FILE__) + '/../test_helper'

class ProductTypeTest < ActiveSupport::TestCase
   fixtures :product_categories, :product_types

  should_require_attributes :name, :product_category_id
  should_require_unique_attributes :name

  should_only_allow_numeric_values_for :id
  should_not_allow_zero_or_negative_number_for :id
end
