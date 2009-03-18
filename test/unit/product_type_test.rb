require File.dirname(__FILE__) + '/../test_helper'

class ProductTypeTest < ActiveSupport::TestCase
   fixtures :product_categories, :product_types

  should_validate_presence_of :name, :product_category_id
  should_validate_uniqueness_of :name

  should_validate_numericality_of :id
  should_not_allow_zero_or_negative_number_for :id
end
